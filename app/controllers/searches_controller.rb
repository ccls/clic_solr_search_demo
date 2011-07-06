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


#	for multiple selections, use .any_of [ .... ]
#	for overlapping selections, use .all_of [ .... ]

#	facet order is preserved, so the order it is listed here
#		will be the order that it is presented in the view

			with  :world_region, params[:world_region] if params[:world_region]
			facet :world_region
			with  :country, params[:country] if params[:country]
			facet :country
			with  :study_name, params[:study_name] if params[:study_name]
			facet :study_name
			with  :recruitment, params[:recruitment] if params[:recruitment]
			facet :recruitment
			with  :study_design, params[:study_design] if params[:study_design]
			facet :study_design
			with  :age_group, params[:age_group] if params[:age_group]
			facet :age_group

			with  :case_status, params[:case_status] if params[:case_status]
			facet :case_status

#	only for case?
			with  :subtype, params[:subtype] if params[:subtype]
			facet :subtype

#	principle investigators

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

