class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      log_in(user)
      flash[:success] = "Welcome back #{user.first_name}!"
      redirect_to root_path
    else
      flash[:danger] = "Hmm, something doesn't look right — please try again!"
      redirect_to login_path
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
