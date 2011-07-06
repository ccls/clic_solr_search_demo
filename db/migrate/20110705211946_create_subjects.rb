class CreateSubjects < ActiveRecord::Migration
	def self.up
		create_table :subjects do |t|
			t.integer :study_id
			t.integer :subid
			t.string :case_status
			t.string :method_cytogenetic_subtyping
			t.string :location_cytogenetic_subtyping
			t.string :subtype
			t.boolean :case_DBS
			t.boolean :case_BM
			t.boolean :case_pretreat_blood
			t.boolean :case_blood
			t.boolean :case_buccal
			t.boolean :case_maternal_blood
			t.boolean :case_paternal_blood
			t.boolean :case_maternal_buccal
			t.boolean :case_paternal_buccal
			t.boolean :control_DBS
			t.boolean :control_blood
			t.boolean :control_buccal
			t.boolean :control_saliva
			t.boolean :control_maternal_blood
			t.boolean :control_paternal_blood
			t.boolean :control_maternal_buccal
			t.boolean :control_paternal_buccal
			t.boolean :control_maternal_saliva
			t.boolean :control_paternal_saliva
			t.boolean :genotyping_phase_I_metabolic
			t.boolean :genotyping_phase_II_metabolic
			t.boolean :genotyping_DNA_repair
			t.boolean :genotyping_immune_function
			t.boolean :genotyping_oxidative_stress
			t.boolean :genotyping_folate_metabolism
			t.boolean :genotyping_other
			t.boolean :cytogenetics_t_12_21
			t.boolean :cytogenetics_inv_16
			t.boolean :cytogenetics_t_1_19
			t.boolean :cytogenetics_t_8_21
			t.boolean :cytogenetics_t_9_22
			t.boolean :cytogenetics_t_15_17
			t.boolean :cytogenetics_11q23_MLL
			t.boolean :cytogenetics_trisomy_5
			t.boolean :cytogenetics_trisomy_21
			t.boolean :cytogenetics_high_hyperdiploid
			t.boolean :cytogenetics_low_hyperdiploid
			t.boolean :cytogenetics_hypodiploid
			t.boolean :cytogenetics_other

			t.timestamps
		end
	end

	def self.down
		drop_table :subjects
	end
end
