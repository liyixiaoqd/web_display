class FinanceLogAnalyController < ApplicationController
	def index
	end
	
	#总调用数据获取
	def index_general_chart
		@start_time=params['start_time']
		@end_time=params['end_time']

		if @start_time.blank?
			@start_time=Time.now.strftime("%Y-%m-%d 00:00:00.000")
		else
			begin
				@start_time.to_time
			rescue
				@start_time=Time.now.strftime("%Y-%m-%d 00:00:00.000")
				flash[:notice]="start_time format wrong!! please input YYYY-MM-DD HH:MM:SS.SSS"
			end
		end

		if @end_time.blank?
			@end_time=Time.now.strftime("%Y-%m-%d 23:59:59.999") 
		else
			begin
				@end_time.to_time
			rescue
				@end_time=Time.now.strftime("%Y-%m-%d 23:59:59.999")
				flash[:notice]="end_time format wrong!! please input YYYY-MM-DD HH:MM:SS.SSS"
			end
		end


		@pie_hash={}
		select_condition="controller,action,sum(count) as total"
		where_condition="storm_topology='finance_log_analysis'"

		where_condition+=" and begtime>='#{@start_time}'" unless @start_time.blank?
		where_condition+=" and endtime<'#{@end_time}'" unless @end_time.blank?

		i=0
		FinanceActionAnalysis.select(select_condition).where(where_condition).group("controller,action").order("total desc").each do |faa|
			i+=1
			if i>5
				key="Other.other"
				if @pie_hash[key].blank?
					@pie_hash[key]=faa.total
				else
					@pie_hash[key]+=faa.total
				end
			else
				key=faa.controller+"."+faa.action
				@pie_hash[key]=faa.total
			end

		end

		@line_hash={}
		select_condition="substr(begtime,1,13) as ymdh,sum(count) as total"
		FinanceActionAnalysis.select(select_condition).where(where_condition).group("ymdh").order("ymdh asc").limit(24).each do |faa|
			key=faa.ymdh
			@line_hash[key]=faa.total
		end
	end

	#提交交易相关数据获取
	def index_submit_action_chart
		@pay_total_hash={}
		@pay_user_times_hash={}

		select_condition="paymode,sum(buy_count) as count_total,sum(buy_amount) as amount_total"
		FinanceUserPaySummary.select(select_condition).group("paymode").each do |fups|
			@pay_total_hash[fups.paymode]=[fups.count_total,fups.amount_total]
		end

		select_condition  ="select case when times>3 and times<6 then 4 "
		select_condition+="when times>=6 and times<10 then 5 "
		select_condition+="when times>=10 then 6 "
		select_condition+="else times end as count_enum,count(*) as count_times "
		select_condition+="from ( "
		select_condition+="select sum(buy_count) as times,userid from finance_user_pay_summary "
		select_condition+="group by userid) t "
		select_condition+="group by count_enum "

		FinanceUserPaySummary.find_by_sql(select_condition).each do |fups|
			if fups.count_enum<=3 
				@pay_user_times_hash[fups.count_enum.to_s]=fups.count_times
			elsif fups.count_enum==4
				@pay_user_times_hash["4-5"]=fups.count_times
			elsif fups.count_enum==5
				@pay_user_times_hash["6-9"]=fups.count_times
			elsif fups.count_enum==6
				@pay_user_times_hash["10+"]=fups.count_times
			end
		end
	end

	def user_pay_times_detail
		@pay_times_first_details={}
		@pay_times_last_details={}
		@count_enum=params['count_enum']

		#first buy times
		select_condition  ="select case when datediff(utc_timestamp,buy_time)<7 then 1 "
		select_condition+="when datediff(utc_timestamp,buy_time)>=7 and datediff(utc_timestamp,buy_time)<14 then 2 "
		select_condition+="when datediff(utc_timestamp,buy_time)>=14 and datediff(utc_timestamp,buy_time)<30 then 3 "
		select_condition+="when datediff(utc_timestamp,buy_time)>=30 and datediff(utc_timestamp,buy_time)<90 then 4 "
		select_condition+="when datediff(utc_timestamp,buy_time)>=90 then 5 end as diff_days,count(*) as diff_count "
		select_condition+="from ( "
		select_condition+="select sum(buy_count) as times,max(last_buy_time) as buy_time,userid from finance_user_pay_summary "
		select_condition+="group by userid) t "

		if params['count_enum'].to_i<=3
			select_condition+="where times=#{params['count_enum'].to_i} "
		elsif params['count_enum']=="4-5"
			select_condition+="where times>3 and times<6 "
		elsif params['count_enum'].to_i=="6-9"
			select_condition+="where times>=6 and times<10 "
		elsif params['count_enum'].to_i=="10+"
			select_condition+="where times>=10 "
		end

		select_condition+="group by diff_days "

		FinanceUserPaySummary.find_by_sql(select_condition).each do |fupd|
			if fupd.diff_days==1
				@pay_times_last_details["一周"]=fupd.diff_count
			elsif fupd.diff_days==2
				@pay_times_last_details["半个月"]=fupd.diff_count
			elsif fupd.diff_days==3
				@pay_times_last_details["一个月"]=fupd.diff_count
			elsif fupd.diff_days==4
				@pay_times_last_details["三个月"]=fupd.diff_count
			else
				@pay_times_last_details["三个月+"]=fupd.diff_count
			end
		end

		#end buy times
	end
end
