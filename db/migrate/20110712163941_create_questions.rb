class CreateQuestions < ActiveRecord::Migration
	def self.up
		create_table :questions do |t|
			t.integer :study_id
			t.string :relation
			t.string :time_period
			t.string :category
			t.string :subcategory
			t.string :level_of_assessment
			t.string :type
			t.text :body
			t.text :subquestion
			t.string :primary_response
			t.text :secondary_question
			t.string :secondary_response
			t.text :tertiary_question
			t.string :tertiary_response
			t.text :quartary_question
			t.string :quartary_response
			t.text :answers
			t.string :standard
			t.boolean :data_available
			t.text :time_period_notes

			t.timestamps
		end
	end

	def self.down
		drop_table :questions
	end
end
