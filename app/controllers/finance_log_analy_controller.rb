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

		FinanceActionAnalysis.select(select_condition).where(where_condition).group("controller,action").order("total desc").limit(5).each do |faa|
			key=faa.controller+"."+faa.action
			@pie_hash[key]=faa.total
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

		select_condition="paymode,sum(buy_count) as count_total,sum(buy_amount) as amount_total"
		FinanceUserPaySummary.select(select_condition).group("paymode").each do |fups|
			@pay_total_hash[fups.paymode]=[fups.count_total,fups.amount_total]
		end
	end
end
