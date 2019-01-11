class UsersController < ApplicationController
  before_action :authorize, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.name = User.full_name(@user)

    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to RLV Cookies 'n' Cream!"
      redirect_to root_path
    else
      flash[:danger] = "Hmm, something doesn't look right — please try again!"
      redirect_to signup_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      @user.update_attributes(name: User.full_name(@user))
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    log_out
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
    end
end
