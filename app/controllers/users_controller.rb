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

      redirect_to dashboard_path
    else
      flash.now[:warning] = @user.errors.full_messages.join(". ")

      render :new
    end
  end

  def show
    unless current_user
      render file: "public/404.html", status: :not_found, layout: true
    end
  end

  def edit
    if current_user
      @user = current_user
    else
      render file: "public/404.html", status: :not_found, layout: true
    end
  end

  def update
    @user = User.find(params[:id])
    billing = @user.addresses.billing.last ||
              Address.new(user_id: @user.id, type_of: 0)
    shipping = @user.addresses.shipping.last ||
               Address.new(user_id: @user.id, type_of: 1)

    if (@user.update_attributes(user_params) &&
        billing.update_attributes(billing_params) &&
        shipping.update_attributes(shipping_params)
       )
      flash[:success] = "Your account has been updated."

      redirect_to dashboard_path
    else
      flash.now[:warning] = @user.errors.full_messages.join(". ")

      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password)
  end

  def billing_params
    params.require(:billing).permit(:address_1,
                                    :address_2,
                                    :city,
                                    :state,
                                    :zip_code)
  end

  def shipping_params
    params.require(:shipping).permit(:address_1,
                                    :address_2,
                                    :city,
                                    :state,
                                    :zip_code)
  end
end
