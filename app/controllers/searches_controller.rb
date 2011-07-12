class SearchesController < ApplicationController

	def show
#
#	should devise some way to determine if the sunspot server is actually running
#	
#	I think that there is a ping method
#

		@exposure_search = Exposure.search do
			facet :category
			if params[:category]
				with :category, params[:category]
				%w( relation_to_child types windows_of_exposure exposure_assessments forms_of_contact locations_of_use frequencies_of_contact frequencies_of_use durations_of_use ).each do |p|
					if params[p]
						with(p).any_of params[p]
					end
					facet p.to_sym
				end
			end
			facet :study_id
		end
		study_ids = @exposure_search.facet(:study_id).rows.collect(&:value)

#		get the study_ids from the exposure search
#		as pass them on to the Subject search.

		@search = Subject.search do
			keywords params[:q]
#	undefined method `name' for "Book":String 
#	where Book is params[:class]
#	either constantize or create String#name method
#	both seem to make Sunspot happy
#			with(:class, params[:class].constantize) if params[:class]
#			facet :class 

#	facet order is preserved, so the order it is listed here
#		will be the order that it is presented in the view

#
#	genotypings not desired at the moment.  When it is, just add to the list after biospecimens
#
			%w( world_region country study_name recruitment study_design age_group principal_investigators case_status subtype biospecimens ).each do |p|
				if params[p]
					if params[p+'_op'] && params[p+'_op']=='AND'
						with(p).all_of params[p]
					else
						with(p).any_of params[p]
					end
				end
				facet p.to_sym
			end

##	what about principle investigators?

			with( :study_id ).any_of( study_ids ) if params[:category]
			facet :study_id

			order_by :created_at, :asc
			paginate :page => params[:page]
		end
	end

end
__END__

CASE STATUS
	Case
		Cytogenetics
			t(12,21)
			inv(16)
			t(1,19)
			t(8,21)
			t(9,22)
			t(15,17)
			11q25/MLL
			Trisomy 5
			Trisomy 21
			High hyperdiploid
			Low hyperdiploid
			Hypodiploid
			Other

