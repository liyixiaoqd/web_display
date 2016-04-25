class AccountingController < ApplicationController
	before_action :check_login,:except => [:login,:login_submit]

	def login
		unless session[:user_id].blank?
			redirect_to accounting_index_path and return
		end
	end

	def login_submit
		unless session[:user_id].blank?
			redirect_to accounting_index_path and return
		end

		begin
			if params['username'].blank? || params['password'].blank?
				raise "please input username and password"
			end

			au=AccountUser.find_by(username: params['username'])
			if au.blank?
				raise "#{params['username']} not registed"
			end


			if  params['password'] != Digest::MD5.hexdigest("#{au.password}#{Time.now.strftime("%Y%m%d")}")
				Rails.logger.info("#{params['password']} <> #{Digest::MD5.hexdigest("#{au.password}#{Time.now.strftime("%Y%m%d")}")}" ) if Rails.env.development?
				raise "password is wrong,please retry"
			end

			flash[:notice] = "login success ! welcome #{au.username}"

			session[:user_id] = au.id
			session[:username] = au.username
		rescue=>e
			flash[:error]=e.message
			redirect_to accounting_login_path and return 
		end

		redirect_to accounting_index_path
	end

	def login_out
		session[:user_id]=nil
		session[:username]=nil

		redirect_to root_path
	end

	def index
		au = AccountUser.find(session[:user_id])
		Rails.logger.info("#{au.id} ===  #{session[:user_id]}")

		#use AccountRecord. paginates_per
		ar_condition = AccountRecord.where(pay_user_id: au.id).page(value_or_default(params[:page],1))
		@ars = ar_condition.order(pay_occurrence_time: :desc)


		@all_income = au.income
		@all_outcome = au.outcome
	end

	def new
		user_id = session[:user_id]

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
			ar.pay_user_id = session[:user_id]
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
			redirect_to accounting_new_path(ar_id: ar.id) and return
		end

		redirect_to accounting_index_path
	end

	def delete_submit

		begin
			ar_id=params['ar_id']
			if ar_id.blank?
				raise "id blank?"
			end
			AccountRecord.find(ar_id).destroy

			flash[:notice]="删除成功!"
		rescue=>e
			flash[:error]=e.message
		end

		redirect_to accounting_index_path
	end

	def user_sync_record
		begin
			au = AccountUser.find(session[:user_id])

			ar_select=AccountRecord.select("sum(pay_amount) as amount,pay_symbol").group(:pay_symbol)
			in_flag=false
			out_flag=false
			ar_select.each do |ar_s|
				if ar_s['pay_symbol']=="收入"
					au.income=ar_s['amount']
					in_flag=true
				elsif ar_s['pay_symbol']=="支出"
					au.outcome=ar_s['amount']
					out_flag=true
				end
			end

			au.income=0.0 unless in_flag
			au.outcome=0.0 unless out_flag
			au.save

			flash[:notice]="同步成功"
		rescue=>e
			flash[:error]="同步失败: #{e.message}"
		end

		redirect_to accounting_index_path
	end

	def search_submit
		au = AccountUser.find(session[:user_id])

		@all_income = au.income
		@all_outcome = au.outcome

		#use AccountRecord. paginates_per
		ar_condition = AccountRecord.where(pay_user_id: au.id).page(value_or_default(params[:page],1))
		ar_condition = ar_condition.where(pay_symbol: params['pay_symbol']) if params['pay_symbol']!="全选"
		ar_condition = ar_condition.where(consumption_type: params['consumption_type']) if params['consumption_type']!="全选"
		ar_condition = ar_condition.where(consumption_sub_type: params['consumption_sub_type']) if params['consumption_sub_type']!="全选"
		ar_condition = ar_condition.where(pay_method: params['pay_method']) if params['pay_method']!="全选"
		ar_condition = ar_condition.where(" pay_amount >= #{params['pay_amount_beg']}") if params['pay_amount_beg'].present?
		ar_condition = ar_condition.where(" pay_amount <= #{params['pay_amount_end']}") if  params['pay_amount_end'].present? && params['pay_amount_end'].to_f>0.0
		ar_condition = ar_condition.where(" pay_partner like '%#{params['pay_partner']}%'") if params['pay_partner'].present?
		ar_condition = ar_condition.where(" pay_reason like '%#{params['pay_reason']}%'") if params['pay_reason'].present?
		if params['pay_occurrence_date_beg'].present?
			ar_condition = ar_condition.where(" pay_occurrence_date>='#{params['pay_occurrence_date_beg']}'")
		end
		if params['pay_occurrence_date_end'].present?
			ar_condition = ar_condition.where(" pay_occurrence_date<='#{params['pay_occurrence_date_end']}'")
		end

		@ars = ar_condition.order(pay_occurrence_time: :desc)


		render accounting_index_path
	end

	private 
		def check_login
			if session[:user_id].blank?
				flash[:error] = "please login !"
				redirect_to accounting_login_path and return
			end

			unless params['ar_id'].blank?
				ar=AccountRecord.find(params['ar_id'])
				if ar.present? && ar.pay_user_id != session[:user_id]
					flash[:error] = "AccountRecord not belong to you !"
					redirect_to accounting_login_path
				end
			end
		end

		def value_or_default(value,default_value)
			if value.blank?
				default_value
			else
				value
			end
		end
end
