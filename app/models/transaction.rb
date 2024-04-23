class Transaction < ApplicationRecord
  include Discard::Model
  include ActiveModel::Dirty
  
  default_scope -> { kept }
  
  belongs_to :account

  enum kind: { income: "income", expense: "expense" }

  validates :name, presence: true
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :kind, presence: true

  before_save :update_account_balance
  before_update :remove_value_from_account_balance

  def update_account_balance
    account = Account.find(account_id)
    
    if self.kind_was.present? && kind_changed? 
      if self.kind == "income"
        account.balance += self.value_was * 2
      else
        account.balance -= self.value_was * 2
      end
    end

    if value_changed?
      prevValue = self.value_was || 0
      if self.kind == "income"
        account.balance += (self.value - prevValue)
      else
        account.balance -= (self.value - prevValue)
      end
    end
    account.save
  end

  def remove_value_from_account_balance
    account = Account.find(account_id)

    if self.discarded_at.present?
      if self.kind == "income"
        account.balance -= self.value
      else
        account.balance += self.value
      end
    end
    account.save
  end
end
