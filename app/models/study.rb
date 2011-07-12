class Study < ActiveRecord::Base

	has_many :subjects
	has_many :exposures
	has_many :questions

	serialize( :principal_investigators, Array )

	# can't use macro style setup for after_find or after_initialize
	def after_initialize
		# set principal_investigators default to empty Array
		self.principal_investigators = Array.new if self.principal_investigators.nil?
	end

	def to_s
		study_name
	end

end
