class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def signinup
    user = User.find_by_email(params[:session][:email])

    if user #sign in
      if user && user.authenticate(params[:session][:password])
        sign_in user
        redirect_to user
      else
        flash.now[:error] = "Invalid password/email combination"
        render 'sessions/new'
      end
    else #sign up
      @user = User.new(params[:session])
      @user[:priv] = 'simple'
      if @user.save
        flash[:success] = "Registration successful"
        sign_in @user
        redirect_to @user
      else
        render 'users/new'
      end
    end
  end
end
