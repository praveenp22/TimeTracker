module LayoutHelper
	def custom_flash
		@layout_flash = false
		bootstrap_flash
	end	

	def show_layout_flash?
		@layout_flash.nil? ? true : false
		
		# ternary operator represented below in if statements
		# if @layout_flash.nil?
		# 	return true
		# else
		# 	return false
		# end
	end
end