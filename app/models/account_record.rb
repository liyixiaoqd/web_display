class AccountRecord < ActiveRecord::Base
	#column desc:
	# t.date :pay_occurrence_date,           :null=>false
	# t.datetime :pay_occurrence_time,  :null=>false
	# t.integer :pay_user_id,       :null=>false
	# t.string :pay_symbol,         :limit=>2,  :null=>false
	# t.decimal :pay_amount,    :precision=>10,:scale=>2,  :null=>false
	# t.string :pay_currency,       :limit=>3,  :null=>false
	# t.string :pay_method,         :limit=>20,  :null=>false
	# t.string :pay_reason
	# t.datetime :pay_actual_time
	# t.string :pay_partner
	# t.string :consumption_type,               :limit=>5,  :null=>false
	# t.string :consumption_sub_type,       :limit=>10
	# t.timestamps null: false

	DEFAULT_PAY_CURRENCY="RMB"
	DEFAULT_PAY_REASON="无"
	
	ENUM_PAY_SYMBOL=%w(支出 收入)
	ENUM_PAY_METHOD=%w(支付宝 信用卡 现金)
	ENUM_CONSUMPTION_TYPE=%w(日常 特殊)
	ENUM_CONSUMPTION_SUB_TYPE=%w(日常_食 日常_衣 日常_住 日常_行 日常_薪资 日常_其他 
						特殊_节日 特殊_其他)

	validates :pay_amount, numericality:{:greater_than=>0.00}
	validates :pay_symbol, inclusion: { in: ENUM_PAY_SYMBOL,message: "%{value} is not a valid pay_symbol" }
	validates :pay_method, inclusion: { in: ENUM_PAY_METHOD,message: "%{value} is not a valid pay_method" }
	validates :consumption_type, inclusion: { in: ENUM_CONSUMPTION_TYPE,message: "%{value} is not a valid consumption_type" }

	before_validation :field_check_and_default


	private 
		def field_check_and_default
			#check
			if consumption_sub_type.present? && consumption_sub_type[0,2]!=consumption_type
				errors.add(:base,"type[#{consumption_type}] and sub_type[#{consumption_sub_type}] not match")
				return false
			end

			if pay_occurrence_date.blank?
				unless pay_occurrence_time.blank?
					self.pay_occurrence_date=pay_occurrence_time
				end
			end

			if pay_method=="信用卡"
				if pay_actual_time.blank?
					errors.add(:base,"type[#{pay_method}] need pay_actual_time")
					return false
				elsif pay_occurrence_time.present? && pay_actual_time<pay_occurrence_time
					errors.add(:base,"type[#{pay_method}] pay_actual_time < pay_occurrence_time ??")
					return false	
				end
			else
				self.pay_actual_time = pay_occurrence_time
			end

			#default set
			if pay_currency.blank?
				self.pay_currency=DEFAULT_PAY_CURRENCY
			end

			if pay_reason.blank?
				self.pay_reason=DEFAULT_PAY_REASON
			end

			return true
		end
end
