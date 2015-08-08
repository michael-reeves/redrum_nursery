class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back to Redrum Nursery, #{user.first_name}" \
        " #{user.last_name}!"
      redirect_to dashboard_path
    else
      flash[:warning] = "Unable to Login with this Email and" \
        " Password combination."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
