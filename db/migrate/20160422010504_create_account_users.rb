class CreateAccountUsers < ActiveRecord::Migration
  def change
    create_table :account_users do |t|
      t.string :username ,		 :limit=>20,	null: false
      t.string :password ,		 null: false
      t.decimal :income,    		:precision=>10,:scale=>2,  :null=>false,:default=>0.0
      t.decimal :outcome,    	:precision=>10,:scale=>2,  :null=>false,:default=>0.0
      t.timestamps null: false
    end

    add_index :account_users,[:username],:name=>"index_account_users_1" 
  end
end
