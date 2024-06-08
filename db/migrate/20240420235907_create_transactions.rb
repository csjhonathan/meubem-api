class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :name
      t.string :description
      t.integer :value
      t.string :kind
      t.integer :position
      t.references :account, null: false, foreign_key: true
      
      t.datetime :discarded_at
      t.timestamps
    end
  end
end
