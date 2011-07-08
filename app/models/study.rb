class Study < ActiveRecord::Base

	has_many :subjects

	serialize :exposures, Array

	def to_s
		study_name
	end

end
