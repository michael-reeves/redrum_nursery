class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    user = User.find(current_user.id)
    @address = user.addresses.new(address_params)

    if @address.save
      flash[:success] = "Address created."
      redirect_to account_edit_path
    else
      flash.now[:warning] = @address.errors.full_messages.join(". ")
      render :new
    end
  end

  def update
    @address = Address.find(params[:id])

    if @address.update(address_params)
      flash[:success] = "Your address has been updated."
      redirect_to account_edit_path
    else
      flash[:warning] = @address.errors.full_messages.join(". ")
      redirect_to account_edit_path
    end
  end

  private

  def address_params
    params.require(:address)
          .permit(:type_of, :address_1, :address_2, :city, :state, :zip_code)
  end
end
