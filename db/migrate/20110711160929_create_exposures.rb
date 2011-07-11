class CreateExposures < ActiveRecord::Migration
  def self.up
    create_table :exposures do |t|
      t.integer :study_id
      t.string :category
      t.string :relation_to_child
      t.text :windows_of_exposure
      t.text :types
      t.text :exposure_assessments   # tobacco
      t.text :forms_of_contact       # pesticides
      t.text :locations_of_use       # pesticides
      t.text :frequencies_of_contact # pesticides
      t.text :frequencies_of_use     # vitamins
      t.text :durations_of_use       # vitamins
      t.text :doses_assessed         # vitamins
      t.timestamps
    end
  end

  def self.down
    drop_table :exposures
  end
end
