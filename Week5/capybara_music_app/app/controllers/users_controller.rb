class UsersController < ApplicationController
  def index
    render :index
  end

  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in!(@user)
      # redirect_to user_url(@user) -- spec specified to do the following:
      redirect_to bands_url
    else
      flash.now[:errors] = "Invalid email or password"
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      render :show
    else
      flash[:errors] = "Could not find user"
      redirect_to users_url
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
