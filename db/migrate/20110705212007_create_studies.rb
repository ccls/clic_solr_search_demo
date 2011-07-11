class CreateStudies < ActiveRecord::Migration
	def self.up
		create_table :studies do |t|
			t.string :study_name
			t.string :world_region
			t.string :subregion
			t.string :country
			t.string :study_design
			t.string :ascertainment
			t.string :recruitment
			t.string :age_group
			t.string :method_cytogenetic_subtyping
			t.string :location_cytogenetic_subtyping
			t.text :overview
			t.timestamps
		end
	end

	def self.down
		drop_table :studies
	end
end
