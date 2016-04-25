module AccountingHelper
	def dynamic_pay_symbol_tag
		pay_symbol_tag={}

		AccountRecord::ENUM_PAY_SYMBOL.each do |eps|
			pay_symbol_tag[eps]=eps
		end
		pay_symbol_tag['全选']='全选'
		pay_symbol_tag
	end

	def dynamic_pay_method_tag
		pay_method_tag={}

		AccountRecord::ENUM_PAY_METHOD.each do |epm|
			pay_method_tag[epm]=epm
		end
		pay_method_tag['全选']='全选'
		pay_method_tag
	end

	def dynamic_consumption_type_tag
		consumption_type_tag={}

		AccountRecord::ENUM_CONSUMPTION_TYPE.each do |ect|
			consumption_type_tag[ect]=ect
		end
		consumption_type_tag['全选']='全选'
		consumption_type_tag
	end

	def dynamic_consumption_sub_type_tag
		consumption_sub_type_tag={}

		AccountRecord::ENUM_CONSUMPTION_SUB_TYPE.each do |ecst|
			consumption_sub_type_tag[ecst]=ecst
		end
		consumption_sub_type_tag['全选']='全选'
		consumption_sub_type_tag
	end
end
