class Study < ActiveRecord::Base
	has_many :subjects

	def to_s
		study_name
	end
end
