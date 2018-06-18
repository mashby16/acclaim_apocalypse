class AccountsController < ApplicationController
  before_action :logged_in, :set_account, only: %w(edit update show)

  def new
    @account = Account.new
  end

  def show
    @candidates = current_user.candidates
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      log_in @account
      flash[:success] = "You've successfully signed up!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    if @account.update_attributes(account_params)
      flash[:success] = "Account updated!"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def set_account
    @account = current_user
  end

  def account_params
    params.require(:account).permit(:username, :email, :password, :password_confirmation)
  end
end
