class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :name
      t.string :description
      t.string :value
      t.string :type
      t.references :account, null: false, foreign_key: true
      
      t.datetime :discarded_at
      t.timestamps
    end
  end
end
