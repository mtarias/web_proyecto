module ApplicationHelper
	def submit_with_cancel(form, name="Cancelar")
		form.submit + link_to(name, '#', {}, :onclick => 'history.go(-1)', :class => "cancel")
	end

	def title(title, translate = true)
		content_for :title, translate ? I18n.t(title) : title
	end

	def link_to_back
		link_to I18n.t(:back), :back
	end

end
