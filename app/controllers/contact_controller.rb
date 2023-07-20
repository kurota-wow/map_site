class ContactController < ApplicationController
  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.valid?
      render :confirm
    else
      render :new
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if params[:back]
      render :new
    else
      ContactMailer.received_email(@contact).deliver_now
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to thanks_path
    end
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
