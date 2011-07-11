# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def multi_select_operator_for(name)
		s  = "<div><span>Multi-select operator</span>\n"
		s << radio_button_tag( "#{name}_op", 'AND',
				( params["#{name}_op"] && params["#{name}_op"] == 'AND' ) )
		s << "<label for='#{name}_op_and'>AND</label>\n"
		s << radio_button_tag( "#{name}_op", 'OR',
				( params["#{name}_op"].blank? || params["#{name}_op"] && params["#{name}_op"] == 'OR' ))
		s << "<label for='#{name}_op_or'>OR</label></div>\n"
	end

	def facet_for(facet,options={})
		#	options include :multiselector, :facetcount
		s  = "<b>#{pluralize(facet.rows.length,facet.name.to_s.titleize)}</b>\n"
		s << multi_select_operator_for(facet.name) if options[:multiselector]
		s << "<ul id='#{facet.name}' class='facet_field'>\n"
		facet.rows.each do |row|
			s << "<li>"
			if options[:radio]
				s << radio_button_tag( "#{facet.name}[]", row.value,
						params[facet.name].include?(row.value),
						{ :id => "#{facet.name}_#{row.value.html_friendly}" } )
			else
				s << check_box_tag( "#{facet.name}[]", row.value, 
						params[facet.name].include?(row.value),
						{ :id => "#{facet.name}_#{row.value.html_friendly}" } )
			end
			s << "<label for='#{facet.name}_#{row.value.html_friendly}'>"
			s << "<span>#{row.value}</span>"
			s << "&nbsp;(&nbsp;#{row.count}&nbsp;)" if options[:facet_counts]
			s << "</label></li>\n"
		end
    s << "</ul>\n"
	end

end
