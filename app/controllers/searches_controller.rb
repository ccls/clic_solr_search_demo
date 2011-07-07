class SearchesController < ApplicationController

	def show
#
#	should devise some way to determine if the sunspot server is actually running
#	
#	I think that there is a ping method
#
#		@search = Sunspot.search(Book,Chapter,Verse) do
		@search = Sunspot.search(Subject) do
			keywords params[:q]
#	undefined method `name' for "Book":String 
#	where Book is params[:class]
#	either constantize or create String#name method
#	both seem to make Sunspot happy
#			with(:class, params[:class].constantize) if params[:class]
#			facet :class 

#	facet order is preserved, so the order it is listed here
#		will be the order that it is presented in the view

			%w( world_region country study_name recruitment study_design age_group case_status subtype biospecimens ).each do |p|
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

#
#	Not desired at the moment
#
#			with(:genotypings).any_of params[:genotypings]	if params[:genotypings]
#			facet :genotypings

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
BIOSPECIMENS
	Case
		Child
			Dried Blood Spot
			Bone Marrow
			Pre-treatment Blood
			Blood
			Buccal
		Maternal
			Blood
			Buccal
		Paternal
			Blood
			Buccal
	Control
		Child
			Dried Blood Spot
			Blood
			Buccal
			Saliva
		Maternal
			Blood
			Buccal
			Saliva
		Paternal
			Blood
			Buccal
			Saliva
GENOTYPING
	Phase I Metabolism
	Phase II Metabolism
	Immune Function
	Folate Metabolism
	DNA Repair
	Oxidative Stress
	Other

