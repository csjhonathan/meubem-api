class User < ApplicationRecord
  include Discard::Model
  include ActiveModel::Dirty
  
  default_scope -> { kept }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  
  has_one :account
  after_create :create_account

  def create_account
    Account.create(user: self)
  end
end
