module ApplicationHelper
	def submit_with_cancel(form, name="Cancelar")
		form.submit + link_to(name, '#', {}, :onclick => 'history.go(-1)', :class => "cancel")
	end

	def title(title, translate = true)
		content_for :title, translate ? t(title) : title
	end

	def link_to_back
		link_to t(:back), :back
	end

	def link_to_c_t(name, route)
		link_to_unless_current t(name), route do
			raw %Q|<div class="selected_link">#{t(name)}</div>|
		end
	end

	def asset_url(asset_path)
		request.protocol + request.host_with_port + asset_path
	end

end
