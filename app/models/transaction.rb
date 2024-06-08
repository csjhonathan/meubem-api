class Transaction < ApplicationRecord
  include Discard::Model
  include ActiveModel::Dirty
  
  default_scope -> { kept }
  
  belongs_to :account

  enum kind: { income: "income", expense: "expense" }

  validates :name, presence: true
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :kind, presence: true

  before_save :update_account_balance, :calculate_positions
  before_update :remove_value_from_account_balance

  def update_account_balance
    account = Account.find(self.account_id)
    
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

  def calculate_positions
    transactions = Transaction.where(account_id: self.account_id)
    if self.position.nil?
      self.position = transactions.maximum(:position).to_i + 1
    elsif self.discarded_at.present?
      transactions.where("position > ?", self.position).each do |transaction|
        transaction.update_columns(position: transaction.position - 1)
      end
    else 
      if self.position > self.position_was
        transactions.where("position > ? AND position <= ?", self.position_was, self.position).each do |transaction|
          transaction.update_columns(position: transaction.position - 1)
        end
      elsif self.position < self.position_was
        transactions.where("position >= ? AND position < ?", self.position, self.position_was).each do |transaction|
          transaction.update_columns(position: transaction.position + 1)
        end
      end
    end
  end
  def remove_value_from_account_balance
    account = Account.find(self.account_id)

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
