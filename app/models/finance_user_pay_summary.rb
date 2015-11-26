class FinanceUserPaySummary < ActiveRecord::Base
	self.table_name='finance_user_pay_summary'
	# 表实际使用复合主键system+userid+paymode
	self.primary_key="userid"
end