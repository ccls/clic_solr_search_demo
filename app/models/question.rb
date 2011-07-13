class Question < ActiveRecord::Base
	belongs_to :study

	searchable do
		integer :study_id, :references => Study
		string  :relation
		string  :time_period
		string  :category
		string  :subcategory
		string  :level_of_assessment
	end

end
__END__

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

