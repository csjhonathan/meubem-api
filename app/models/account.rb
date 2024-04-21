class Account < ApplicationRecord
  include Discard::Model
  include ActiveModel::Dirty
  
  default_scope -> { kept }

  belongs_to :user
  has_many :transactions
end
