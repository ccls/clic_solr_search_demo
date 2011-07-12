class CreateQuestions < ActiveRecord::Migration
	def self.up
		create_table :questions do |t|
			t.integer :study_id
			t.string  :relation
			t.string  :time_period
			t.string  :category
			t.string  :subcategory
			t.string  :level_of_assessment
			t.string  :question_type
			t.text    :primary_question
			t.text    :primary_subquestion
			t.string  :primary_response
			t.text    :secondary_question
			t.string  :secondary_response
			t.text    :tertiary_question
			t.string  :tertiary_response
			t.text    :quarternary_question
			t.string  :quarternary_response
			t.text    :answers
			t.string  :standard
			t.boolean :data_available
			t.text    :time_period_notes

			t.timestamps
		end
	end

	def self.down
		drop_table :questions
	end
end
