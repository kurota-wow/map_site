require 'rails_helper'

RSpec.describe "Contacts" do
  before do
    driven_by(:selenium_chrome_headless)
  end

  after do
    ActionMailer::Base.deliveries.clear
  end

  let!(:valid_params) { attributes_for(:contact) }
  let!(:invalid_params) { attributes_for(:contact, name: nil) }

  describe "#new, #confirm" do
    before do
      visit new_contact_path
    end

    context "when accessing new page" do
      it "displays contact page text" do
        visit new_contact_path
        expect(page).to have_content("お名前")
        expect(page).to have_content("メールアドレス")
        expect(page).to have_content("お問い合わせ内容")
      end
    end

    context "when accessing confirm page with valid params" do
      it "displays confirm page" do
        fill_in 'contact[name]', with: valid_params[:name]
        fill_in 'contact[email]', with: valid_params[:email]
        fill_in 'contact[message]', with: valid_params[:message]
        click_button '入力内容確認'
        expect(page).to have_current_path(confirm_path)
        expect(page).to have_content(valid_params[:name])
        expect(page).to have_content(valid_params[:email])
        expect(page).to have_content(valid_params[:message])
      end
    end

    context "when accessing confirm page with invalid params" do
      it "displays error message" do
        fill_in 'contact[name]', with: ""
        fill_in 'contact[email]', with: valid_params[:email]
        fill_in 'contact[message]', with: valid_params[:message]
        click_button '入力内容確認'
        expect(page).to have_selector('strong', text: "入力内容にエラーがあります")
        expect(page).to have_selector('.alert')
        expect(page).to have_text("名前を入力してください")
      end
    end
  end

  describe "#create" do
    before do
      visit new_contact_path
      fill_in 'contact[name]', with: valid_params[:name]
      fill_in 'contact[email]', with: valid_params[:email]
      fill_in 'contact[message]', with: valid_params[:message]
      click_button '入力内容確認'
    end

    context "when click on back button" do
      it "holds the value" do
        click_button '戻る'
        expect(page).to have_field('contact[name]', with: valid_params[:name])
        expect(page).to have_field('contact[email]', with: valid_params[:email])
        expect(page).to have_field('contact[message]', with: valid_params[:message])
      end
    end

    context "when send email with valid params" do
      it "displays thanks page" do
        click_button '送信'
        expect(page).to have_current_path(thanks_path)
        expect(page).to have_text("お問い合わせいただきありがとうございました。")
      end
    end
  end
end
