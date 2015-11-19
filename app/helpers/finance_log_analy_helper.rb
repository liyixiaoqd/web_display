module FinanceLogAnalyHelper
	def getBegTime(use)
		getOrDefaultValue(use,Time.now.strftime("%Y-%m-%d 00:00:00.000"))
	end

	def getEndTime(use)
		getOrDefaultValue(use,Time.now.strftime("%Y-%m-%d 23:59:59.999"))
	end
end
