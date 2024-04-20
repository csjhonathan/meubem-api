class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include JsonWebToken

  before_action :authenticate_user!

  private
    def authenticate_user!
      header = request.headers["Authorization"]
      token = header.split(" ").last if header
      return render json: {message: "Autorização não encontrada"}, status: :unauthorized if token.nil?

      decoded = jwt_decode(token)
      @current_user = User.find(decoded[:user_id])
      return render json: {message: "Usuário inválido"}, status: :unauthorized if @current_user.nil?
    end  
end
