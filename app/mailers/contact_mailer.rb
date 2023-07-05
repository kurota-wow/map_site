class ContactMailer < ApplicationMailer
  default from: "example@example.com"

  def received_email(contact)
    @contact = contact
    mail(:to => contact.email, :subject => 'お問い合わせを承りました')
  end
  
end
