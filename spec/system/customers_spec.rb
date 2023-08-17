require 'rails_helper'

RSpec.describe "Customers" do
  before do
    driven_by(:selenium_chrome_headless)
    ActionMailer::Base.deliveries.clear
  end

  after do
    ActionMailer::Base.deliveries.clear
  end

  describe 'Customer system' do
    let!(:customer) { attributes_for(:customer, email: "user@example.com") }
    let!(:invalid_customer) { attributes_for(:customer, name: "") }

    context 'when accessing sign up page with valid params' do
      it "customer can sign up" do
        visit new_customer_registration_path
        fill_in "名前", with: customer[:name]
        fill_in "メールアドレス", with: customer[:email]
        fill_in "パスワード", with: customer[:password]
        fill_in "確認用パスワード", with: customer[:password]
        click_button "新規登録する"
        expect(ActionMailer::Base.deliveries.size).to eq(1)
        customer = Customer.last
        expect(customer.name).to eq(customer[:name])
        expect(customer.email).to eq(customer[:email])
      end
    end

    context 'when accessing sign up page with invalid params' do
      it "customer can not sign up" do
        visit new_customer_registration_path
        fill_in "名前", with: invalid_customer[:name]
        fill_in "メールアドレス", with: invalid_customer[:email]
        fill_in "パスワード", with: invalid_customer[:password]
        fill_in "確認用パスワード", with: invalid_customer[:password]
        click_button "新規登録する"
        expect(ActionMailer::Base.deliveries.size).to eq(0)
      end
    end

    context 'when accessing log in page and log out page' do
      it "customer can log in and log out" do
        other_customer = create(:customer, email: "other_customer@example.com")
        other_customer.confirm
        visit new_customer_session_path
        fill_in "メールアドレス", with: other_customer.email
        fill_in "パスワード", with: other_customer.password
        click_button "ログイン"
        expect(page).to have_text("ログインしました。")
        find(".responsive-btn").click
        click_button "ログアウト"
        expect(page).to have_text("ログアウトしました。")
      end
    end
  end

  describe 'My Page' do
    let!(:customer) { create(:customer, email: 'test@example.com') }
    let!(:other_customer) { create(:customer, email: 'other@example.com') }
    let!(:spot) { create(:spot) }
    let!(:comments) { create_list(:spot_comment, 6, customer:, spot:) }
    let!(:bookmarked_spot) { create(:bookmark, customer:, spot:) }

    context 'when signed in as the current customer' do
      before do
        customer.confirm
        sign_in(customer)
        visit customer_path(customer)
      end

      context 'when viewing the user tab' do
        it 'displays the customer details and allows profile edit' do
          expect(page).to have_content(customer.name)
          expect(page).to have_content(customer.email)
          click_link '編集する'
          fill_in 'customer[name]', with: 'New Name'
          fill_in 'customer[current_password]', with: 'password'
          click_button '更新する'
          expect(page).to have_content('New Name')
        end

        it 'allows the customer to delete their account' do
          click_button '退会する'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content('アカウントを削除しました。またのご利用をお待ちしております。')
        end

        it 'does not display the comments tab content' do
          expect(page).not_to have_css('.comments-tab')
        end

        it 'does not display the bookmarks tab content' do
          expect(page).not_to have_css('.bookmarks-tab')
        end
      end

      context 'when clicking on the comments tab' do
        before do
          find('li[data-tab="comments"]').click
        end

        it 'displays the comments tab content and customer comments' do
          expect(page).to have_css('.comments-tab')
          comments.each do |comment|
            expect(page).to have_content(comment.content)
          end
        end

        it 'can navigate through comment pages using pagination' do
          within '.comments-tab' do
            expect(page).to have_selector('.comment', count: 5)
            click_link '2'
            expect(page).to have_selector('.comment', count: 1)
          end
        end

        it 'can click on a comment spot link' do
          click_link comments[0].spot.name
          expect(page).to have_current_path(spot_path(comments[0].spot), ignore_query: true)
        end

        it 'can click on the delete comment button' do
          click_link '2'
          accept_alert do
            click_button '削除する'
          end
          expect(page).to have_content('コメントを削除しました。')
        end
      end

      context 'when clicking on the bookmarks tab' do
        before do
          find('li[data-tab="bookmarks"]').click
        end

        it 'displays the bookmarks tab content and bookmarked spots' do
          expect(page).to have_css('.bookmarks-tab')
          expect(page).to have_content(bookmarked_spot.spot.name)
        end

        it 'can click on a bookmarked spot link' do
          click_link bookmarked_spot.spot.name
          expect(page).to have_current_path(spot_path(bookmarked_spot), ignore_query: true)
        end

        it 'can click on the bookmark remove button' do
          bookmark_button = find("button[data-spot-id='#{bookmarked_spot.spot.id}']")
          bookmark_button.click
          expect(page).to have_content('お気に入りから削除しました。')
        end
      end
    end

    context 'when signed in as a different customer' do
      before do
        other_customer.confirm
        sign_in(other_customer)
      end

      it 'redirects to the root path' do
        visit customer_path(customer)
        expect(page).to have_current_path(root_path, ignore_query: true)
      end
    end

    context 'when not signed in' do
      it 'redirects to the sign-in page' do
        visit customer_path(customer)
        expect(page).to have_current_path(new_customer_session_path, ignore_query: true)
      end
    end
  end
end
