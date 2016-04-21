class CreateAccountRecords < ActiveRecord::Migration
  def change
    create_table :account_records do |t|
      t.date :pay_occurrence_date,           :null=>false
      t.datetime :pay_occurrence_time,  :null=>false
      t.integer :pay_user_id,       :null=>false
      t.string :pay_symbol,         :limit=>2,  :null=>false
      t.decimal :pay_amount,    :precision=>10,:scale=>2,  :null=>false
      t.string :pay_currency,       :limit=>3,  :null=>false
      t.string :pay_method,         :limit=>20,  :null=>false
      t.string :pay_reason
      t.datetime :pay_actual_time
      t.string :pay_partner
      t.string :consumption_type,               :limit=>5,  :null=>false
      t.string :consumption_sub_type,       :limit=>10
      t.timestamps null: false
    end

    add_index :account_records,[:pay_user_id,:pay_occurrence_date],:name=>"index_account_records_1"
  end
end
