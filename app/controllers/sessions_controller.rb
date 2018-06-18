class SessionsController < ApplicationController
  def new
  end

  def create
    account = Account.find_by(email: params[:session][:email].downcase)
    if account && account.authenticate(params[:session][:password])
      log_in account
      redirect_to root_path
    else
      flash.now[:danger] = 'Something went wrong.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def account_params
    params.require(:account).permit(:email, :password)
  end
end
