class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.string :month
      t.integer :amount
      t.integer :total_inv

      t.timestamps
    end
  end
end
