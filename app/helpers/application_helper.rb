module ApplicationHelper
	def getOrDefaultValue(use,default)
		if use.blank?
			default
		else
			use
		end
	end
end
