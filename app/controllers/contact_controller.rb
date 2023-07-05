class ContactController < ApplicationController
  def index
    @contact = Contact.new
    render :index
  end

  def confirm
    @contact = Contact.new(params[:contact].permit(:name, :email, :message))
    if @contact.valid?
      render :confirm
    else
      render :index
    end
  end

  def thanks
    @contact = Contact.new(params[:contact].permit(:name, :email, :message))
    ContactMailer.received_email(@contact).deliver
    render :thanks
  end
end
