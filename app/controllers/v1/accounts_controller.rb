class V1::AccountsController < ApplicationController
  def show
    account = Account.find_by(user_id: @current_user.id)
    render json: { data: account }, status: 200
  end
end