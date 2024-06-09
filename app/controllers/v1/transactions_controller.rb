class V1::TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]

  def index
    transactions = Transaction.where(account_id: @current_user.account.id).order(position: :asc)
    render json: { data: transactions}, status: :ok
  end

  def show 
    render json: { data: @transaction }, status: :ok
  end

  def create
    transaction = Transaction.new(transaction_params)
    if transaction.save
      render json: { data: transaction }, status: :created
    else
      render json: { data: transaction.errors }, status: :unprocessable_entity
    end
  end
  
  def update
    if @transaction.update(transaction_params)
      render json: { data: @transaction }, status: :ok
    else
      render json: { data: @transaction.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @transaction.discard
      render json: { data: @transaction, message: "Transação deletada com sucesso!" }, status: :ok
    else
      render json: { data: @transaction.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find_by(id: params[:id])
    render json: { data: "Transação não encontrada ou deletada!" }, status: :not_found unless @transaction.present?
  end

  def transaction_params
    params.require(:transaction).permit(
      :name,
      :description,
      :value,
      :kind,
      :account_id, 
      :position,
      :date
    )
  end
end