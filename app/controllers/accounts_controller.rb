class AccountsController < ApplicationController

  def edit
    @account = Account.where(id: current_user.account.id)
  end

  def update
    @account = Account.where(id: current_user.account.id)

    if @account.update(account_params)
      redirect_to :root
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:account).permit(:first_name, :last_name, :photo)
  end
end
