module ApplicationHelper
	def submit_with_cancel(form, name="Cancelar")
		form.submit + link_to(name, '#', {}, :onclick => 'history.go(-1)', :class => "cancel")
	end

	def title(title)
		content_for :title, I18n.t(title)
	end

end
