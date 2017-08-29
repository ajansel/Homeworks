class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:email], user_params[:password])

    if @user
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = "Invalid username or password"
      redirect_to new_session_url
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
