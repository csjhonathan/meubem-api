class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :balance, default: 0

      t.datetime :discarded_at
      t.timestamps
    end
  end
end
