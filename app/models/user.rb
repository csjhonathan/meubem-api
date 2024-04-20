class User < ApplicationRecord
  include Discard::Model
  include ActiveModel::Dirty
  
  default_scope -> { kept }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
end
