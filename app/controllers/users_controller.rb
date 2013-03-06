class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user[:priv] = 'simple'
    #@user[:password_confirmation] = @user[:password]
    if @user.save
      flash[:success] = "Registration successful"
      redirect_to @user
    else
      render 'new'
    end
  end
end