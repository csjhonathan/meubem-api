class V1::UsersController < ApplicationController
  def show
    render json: { data: UserShowSerializerSerializer.new(@current_user) }, status: 200
  end
end