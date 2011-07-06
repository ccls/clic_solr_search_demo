class Subject < ActiveRecord::Base
	belongs_to :study

	delegate :study_name, :to => :study
	delegate :world_region, :to => :study
	delegate :subregion, :to => :study
	delegate :country, :to => :study
	delegate :study_design, :to => :study
	delegate :ascertainment, :to => :study
	delegate :age_group, :to => :study
	delegate :recruitment, :to => :study

	searchable do 
		integer :study_id
		string :study_name
#		string :study_name_and_id		#	may be nice to have both available in facet for link_to ?
		string :world_region
		string :subregion
		string :country
		string :study_design
		string :ascertainment
		string :age_group
		string :recruitment

		string :method_cytogenetic_subtyping			#	may be more study related
		string :location_cytogenetic_subtyping		#	may be more study related

		integer :subid
		string :case_status
		string :subtype

#	Why the separation of case_* and control_*?
#	These MAY also be study related, rather than subject.
#		If so, that may explain the separation.  
#		The study may have not collected blood from control, but did from case.
#		However, based on the input file of 60k+ subjects, this is not true.
#			Not all subjects from the same study have the same values.

		boolean :case_DBS
		boolean :case_BM
		boolean :case_pretreat_blood
		boolean :case_blood
		boolean :case_buccal
		boolean :case_maternal_blood
		boolean :case_paternal_blood
		boolean :case_maternal_buccal
		boolean :case_paternal_buccal
		boolean :control_DBS
		boolean :control_blood
		boolean :control_buccal
		boolean :control_saliva
		boolean :control_maternal_blood
		boolean :control_paternal_blood
		boolean :control_maternal_buccal
		boolean :control_paternal_buccal
		boolean :control_maternal_saliva
		boolean :control_paternal_saliva
		boolean :genotyping_phase_I_metabolic
		boolean :genotyping_phase_II_metabolic
		boolean :genotyping_DNA_repair
		boolean :genotyping_immune_function
		boolean :genotyping_oxidative_stress
		boolean :genotyping_folate_metabolism
		boolean :genotyping_other
		boolean :cytogenetics_t_12_21
		boolean :cytogenetics_inv_16
		boolean :cytogenetics_t_1_19
		boolean :cytogenetics_t_8_21
		boolean :cytogenetics_t_9_22
		boolean :cytogenetics_t_15_17
		boolean :cytogenetics_11q23_MLL
		boolean :cytogenetics_trisomy_5
		boolean :cytogenetics_trisomy_21
		boolean :cytogenetics_high_hyperdiploid
		boolean :cytogenetics_low_hyperdiploid
		boolean :cytogenetics_hypodiploid
		boolean :cytogenetics_other
		time :created_at
		time :updated_at
	end

	def to_s
		study_name
	end
end

__END__

"study attributes::design","age group","study attributes::recruitment","case status::case::subtype","case status::case::biospecimen::maternal","case status::case::biospecimen::paternal","case status::case::biospecimen::maternal","case status::case::biospecimen::paternal","genotyping","genotyping","genotyping","genotyping","genotyping","genotyping","case status::case::cytogenetics::t 12 21","case status::case::cytogenetics::inv 16","case status::case::cytogenetics::t 1 19","case status::case::cytogenetics::t 8 21","case status::case::cytogenetics::t 9 22","case status::case::cytogenetics::t 15 17","case status::case::cytogenetics::11q23 mll","case status::case::cytogenetics::trisomy 5","case status::case::cytogenetics::trisomy 21","case status::case::cytogenetics::high hyperdiploid","case status::case::cytogenetics::low hyperdiploid","case status::case::cytogenetics::hypodiploid","case status::case::cytogenetics::other","exposure::any::relation to child","exposure::tobacco::relation to child","exposure::tobacco::window of exposure","exposure::tobacco::type","exposure::tobacco::exposure assessment","exposure::pesticides::relation to child","exposure::pesticides::windows of exposure","exposure::pesticides::windows of exposure","exposure::pesticides::windows of exposure","exposure::pesticides::type","exposure::pesticides::type","exposure::pesticides::type","exposure::pesticides::type","exposure::pesticides::type","exposure::pesticides::type","exposure::pesticides::type","exposure::pesticides::form of contact","exposure::pesticides::location of use","exposure::pesticides::frequency of contact assessment","exposure::vitamins::relation to child","exposure::vitamins::windows of exposure","exposure::vitamins::windows of exposure","exposure::vitamins::windows of exposure","exposure::vitamins::windows of exposure","exposure::vitamins::type","exposure::vitamins::type","exposure::vitamins::type","exposure::vitamins::frequency of use","exposure::vitamins::duration of use"
