class AccountsController < ApplicationController

  def show
    @account = Account.where(user: current_user)
  end
end
