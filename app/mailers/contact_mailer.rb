class ContactMailer < ApplicationMailer
  default from: "noreply@example.com"
  default to: 'admin@example.com'

  def received_email(contact)
    @contact = contact
    mail(from: contact.email, to: Rails.application.credentials.gmail[:to_mail], subject: 'Webサイトより問い合わせが届きました') do |format|
      format.text
    end
  end

  def send_mail(contact)
    @contact = contact
    mail(from: contact.email, to: @contact.email, subject: 'お問合せありがとうございます。') do |format|
      format.text
    end
  end
end
