class Question < ActiveRecord::Base
	belongs_to :study

	searchable do
		integer :study_id, :references => Study
	end

end
