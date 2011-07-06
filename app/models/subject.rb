class Subject < ActiveRecord::Base
	belongs_to :study

	serialize( :biospecimens, Array )
	serialize( :genotypings, Array )

	# can't use macro style setup for after_find or after_initialize
	def after_initialize
		# set biospecimens default to empty Array
		self.biospecimens = Array.new if self.biospecimens.nil?
		# set genotypings default to empty Array
		self.genotypings = Array.new if self.genotypings.nil?
	end

	delegate :study_name,
		:world_region,
		:subregion,
		:country,
		:study_design,
		:ascertainment,
		:age_group,
#		:method_cytogenetic_subtyping,
#		:location_cytogenetic_subtyping,
		:recruitment, :to => :study, :allow_nil => true

	searchable do 
		integer :study_id, :references => Study
		string :study_name
		string :world_region
		string :subregion
		string :country
		string :study_design
		string :ascertainment
		string :age_group
		string :recruitment

#		string :method_cytogenetic_subtyping			#	may be more study related
#		string :location_cytogenetic_subtyping		#	may be more study related

		integer :subid
		string :case_status
		string :subtype
		string :genotypings, :multiple => true
		string :biospecimens, :multiple => true

#	Why the separation of case_* and control_*?
#	These MAY also be study related, rather than subject.
#		If so, that may explain the separation.  
#		The study may have not collected blood from control, but did from case.
#		However, based on the input file of 60k+ subjects, this is not true.
#			Not all subjects from the same study have the same values.
#
#		boolean :case_DBS
#		boolean :case_BM
#		boolean :case_pretreat_blood
#		boolean :case_blood
#		boolean :case_buccal
#		boolean :case_maternal_blood
#		boolean :case_paternal_blood
#		boolean :case_maternal_buccal
#		boolean :case_paternal_buccal
#		boolean :control_DBS
#		boolean :control_blood
#		boolean :control_buccal
#		boolean :control_saliva
#		boolean :control_maternal_blood
#		boolean :control_paternal_blood
#		boolean :control_maternal_buccal
#		boolean :control_paternal_buccal
#		boolean :control_maternal_saliva
#		boolean :control_paternal_saliva
#
#		boolean :genotyping_phase_I_metabolic
#		boolean :genotyping_phase_II_metabolic
#		boolean :genotyping_DNA_repair
#		boolean :genotyping_immune_function
#		boolean :genotyping_oxidative_stress
#		boolean :genotyping_folate_metabolism
#		boolean :genotyping_other

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
		"#{subid} : #{case_status} : #{subtype}"
	end
end
