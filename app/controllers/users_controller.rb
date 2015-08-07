class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Redrum Nursery," \
        " #{@user.first_name} #{@user.last_name}!"

      redirect_to dashboard_path(user_id: @user.id)
    else
      #TODO: Add sad path
    end
  end

  def show
    @user = User.find(params[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password)
  end
end
