require 'rails_helper'

RSpec.describe 'SpotComments' do
  let!(:customer) { create(:customer) }
  let!(:spot) { create(:spot) }
  let!(:spot_comment) { create(:spot_comment, customer:, spot:) }

  before do
    driven_by(:selenium_chrome_headless)
    customer.confirm
    sign_in customer
    visit spot_path(spot)
  end

  it 'creates a new spot comment and displays it' do
    fill_in 'コメントを入力してください  （５文字以上１４０文字以内）', with: '新しいコメント'
    click_button 'コメントする'
    expect(page).to have_content('新しいコメント')
  end

  it 'fails to create a new spot comment with invalid content' do
    fill_in 'コメントを入力してください  （５文字以上１４０文字以内）', with: ''
    click_button 'コメントする'
    expect(page).to have_content('コメントの投稿に失敗しました。')
  end

  it 'deletes a spot comment owned by the customer' do
    within "#comment-body" do
      click_button '削除する'
      page.accept_confirm
    end
    expect(page).to have_content('コメントを削除しました。')
    expect(page).not_to have_content(spot_comment.content)
  end

  it 'fails to delete a spot comment not owned by the customer' do
    other_customer = create(:customer, email: "other_customer@example.com")
    create(:spot_comment, customer: other_customer, spot:, content: "Other Text")
    visit spot_path(spot)
    expect(page).to have_button('削除する', exact: true, count: 1)
  end

  it 'checks pagination' do
    create_list(:spot_comment, 5, customer:, spot:)
    visit spot_path(spot)
    expect(page).to have_selector('.comment', count: 5)
    click_link '2'
    expect(page).to have_selector('.comment', count: 1)
  end

  it 'cancels deletion with confirmation dialog' do
    within "#comment-body" do
      click_button '削除する'
      page.dismiss_confirm
    end
    expect(page).not_to have_content('コメントを削除しました。')
    expect(page).to have_content(spot_comment.content)
  end

  it 'checks comment contents, name, and delete button' do
    expect(page).to have_content(spot_comment.customer.name)
    expect(page).to have_content(spot_comment.content)
    expect(page).to have_button('削除する', exact: true)
  end

  it 'reflects on the customer my page' do
    visit customer_path(customer)
    find('li[data-tab="comments"]').click
    expect(page).to have_content(spot_comment.content)
  end
end
