class CreateInvestments < ActiveRecord::Migration
  def up
    create_table :investments do |t|
      t.string :month
      t.integer :amount
      t.integer :total_inv
      t.references :user, index: true
      t.timestamps
    end
  end

  def down
  	drop_table :investments
  end
end
