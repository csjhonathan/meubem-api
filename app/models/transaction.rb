class Transaction < ApplicationRecord
  include Discard::Model
  include ActiveModel::Dirty
  
  default_scope -> { kept }
  
  belongs_to :account

  enum kind: { income: "income", expense: "expense" }

  validates :name, presence: true
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :kind, presence: true

  after_save :update_account_balance

  def update_account_balance
    account = Account.find(account_id)
    if self.kind == "income"
      account.balance += self.value
    else
      account.balance -= self.value
    end
    account.save
  end
end
