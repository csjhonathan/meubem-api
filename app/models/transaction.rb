class Transaction < ApplicationRecord
  include Discard::Model
  include ActiveModel::Dirty
  
  default_scope -> { kept }
  
  belongs_to :account
end
