class V1::AuthsController < ApplicationController
  before_action :check_registered_user, only: :sign_up

  def sign_up
    user = User.new(user_params)
    if user.save
      render json: { message: "Usuário cadastrado com sucesso!", data:user }, status: 201
    else
      render json: { message: user.errors.full_messages }, status: 400
    end
  end

  def sign_in
    user = User.find_by(email: params[:user][:email])

    return render json: { message: "Usuário não encontrado!" }, status: 404 unless user.present?

    if user.valid_password?(params[:user][:password])
      render json: { message: "Usuário logado com sucesso!", data: { authentication_token: jwt_encode({ user_id: user.id }) } }, status: 200
    else
      render json: { message: "Verifique o email ou a senha!"}, status: 422
    end
  end

  private

  def check_registered_user
    @user = User.find_by(email: params[:user][:email])
    
    if @user.present?
      return render json: { message: "Usuário já existe!" }, status: 400
    end
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation
    )
  end
end