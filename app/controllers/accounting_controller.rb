class AccountingController < ApplicationController
	REALM = "Accounting"

	before_action :authenticate


	def index
		ar_condition = AccountRecord.where(pay_user_id: 1)
		@ars = ar_condition.order(pay_occurrence_time: :asc).limit(11)

		@all_income = ar_condition.where(pay_symbol: "收入").sum(:pay_amount)
		@all_outcome = ar_condition.where(pay_symbol: "支出").sum(:pay_amount)

		if @all_income.blank?
			@all_income=0.0
		end
		
		if @all_outcome.blank?
			@all_outcome=0.0
		end
	end

	def new
		user_id=params['user_id']

		#修改
		if params['ar_id'].blank?
			@ar=AccountRecord.new(
				pay_occurrence_time: Time.now,
				pay_amount: 0.0
			)
		else
			@ar=AccountRecord.find(params['ar_id'])
		end
	end

	def new_submit

		begin
			if params['oper_type']=="update"
				ar=AccountRecord.find(params['ar_id'])
			else
				ar=AccountRecord.new
			end

			ar.pay_occurrence_time = params['pay_occurrence_time']
			ar.pay_user_id = 1
			ar.pay_symbol = params['pay_symbol']
			ar.pay_amount = params['pay_amount']
			ar.pay_method = params['pay_method']
			ar.pay_reason = params['pay_reason']
			ar.pay_actual_time = params['pay_actual_time']
			ar.pay_partner = params['pay_partner']
			ar.consumption_type = params['consumption_type']
			ar.consumption_sub_type = params['consumption_sub_type']

			ar.save!

			flash[:notice]="新增成功!"
		rescue=>e
			flash[:error]=e.message
			redirect_to accounting_new_path(1,ar_id: ar.id) and return
		end

		redirect_to accounting_index_path
	end

	def delete_submit

		begin
			ar_id=params['ar_id']
			if ar_id.blank?
				raise "id blank?"
			end
			AccountRecord.find(ar_id).delete

			flash[:notice]="删除成功!"
		rescue=>e
			flash[:error]=e.message
		end

		redirect_to accounting_index_path
	end

	private 
		def authenticate
			authenticate_or_request_with_http_digest(REALM) do |username|
				if username=="liyixiaoqd"
					Digest::MD5.hexdigest([username,REALM,"accounting"].join(":"))
				else
					nil
				end
			end
		end
end
