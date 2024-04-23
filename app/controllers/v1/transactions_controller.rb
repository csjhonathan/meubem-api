class V1::TransactionsController < ApplicationController
  def index
    transactions = Transaction.where(account_id: @current_user.account.id)
    render json: { data: transactions}, status: :ok
  end

  def show 
    transaction = Transaction.find_by(id: params[:id])
    render json: { data: transaction }, status: :ok
  end

  def create
    transaction = Transaction.new(transaction_params)
    if transaction.save
      render json: { data: transaction }, status: :created
    else
      render json: { data: transaction.errors }, status: :unprocessable_entity
    end
  end


  def transaction_params
    params.require(:transaction).permit(
      :name,
      :description,
      :value,
      :kind,
      :account_id, 
    )
  end
end