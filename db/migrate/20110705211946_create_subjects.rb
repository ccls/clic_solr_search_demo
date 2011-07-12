class CreateSubjects < ActiveRecord::Migration
	def self.up
		create_table :subjects do |t|
			t.integer :study_id
			t.integer :subid
			t.string :case_status
			t.string :subtype
			t.string :sex     #	pending
			t.string :race    #	pending
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
			t.text :biospecimens
			t.text :genotypings
			t.timestamps
		end
	end

	def self.down
		drop_table :subjects
	end
end
