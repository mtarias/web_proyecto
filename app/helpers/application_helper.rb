module ApplicationHelper
	def submit_with_cancel(form, name="Cancelar")
		form.submit + link_to(name, "javascript.history.go(-1);", :class => "cancel")
	end

end
