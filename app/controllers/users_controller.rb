class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Redrum Nursery," \
        " #{@user.first_name} #{@user.last_name}!"
      redirect_to dashboard_path
    else
      flash.now[:warning] = @user.errors.full_messages.join(". ")
      render :new
    end
  end

  def show
  end

  def edit
    @user = current_user
    @billing = @user.addresses.billing.last
    @shipping = @user.addresses.shipping.last
  end

  def update
    @user = current_user
    @billing = @user.addresses.billing.last
    @shipping = @user.addresses.shipping.last
    
    if !@user.authenticate(params[:user][:password])
      flash.now[:warning] =
        "Invalid password. Please re-enter to update your login info."
    elsif @user.update(user_params)
      flash.now[:success] = "Your account has been updated."
    else
      flash.now[:warning] = @user.errors.full_messages.join(". ")
    end

    render :edit
  end

  private

  def user_params
    params.require(:user)
          .permit(:first_name, :last_name, :email, :password)
  end

  def logged_in_user
    unless current_user
      flash[:warning] = "Please log in."
      redirect_to login_path
    end
  end
end
