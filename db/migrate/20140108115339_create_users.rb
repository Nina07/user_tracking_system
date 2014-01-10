class CreateUsers < ActiveRecord::Migration
  
    def up
      create_table :users do |t|
      t.string :name
      t.string :password
      t.string :type
      t.integer :salary
      t.integer :total_amount
      t.timestamps
    end
  end

  def down
    drop_table :users
  end

  
end
