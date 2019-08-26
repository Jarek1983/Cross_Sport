class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  def new
  	@message = Message.new
  end

  def create
  	@message = Message.new(message_params)
  	# @user = current_user

  	  if verify_recaptcha(model: @message) && @message.save
  	  	MessageMailer.with(message: @message).welcome_email.deliver_later
  	  	flash[:notice] = "Wysłałeś wiadomość"
  	  	redirect_to root_path
  	  else
  	  	render 'new'
  	  end
  	end

private

  def message_params
  	params.require(:message).permit(:name, :email, :body)
  end

end
