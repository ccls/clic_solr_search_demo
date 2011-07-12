class Exposure < ActiveRecord::Base
	belongs_to :study

	serialize( :types, Array )
	serialize( :windows_of_exposure, Array )
	serialize( :exposure_assessments, Array )
	serialize( :forms_of_contact, Array )
	serialize( :locations_of_use, Array )
	serialize( :frequencies_of_contact, Array )
	serialize( :frequencies_of_use, Array )
	serialize( :durations_of_use, Array )

#	NOTE not yet imported
	serialize( :doses_assessed, Array )

	# can't use macro style setup for after_find or after_initialize
	def after_initialize
		# set types default to empty Array
		self.types = Array.new if self.types.nil?
		# set windows default to empty Array
		self.windows_of_exposure = Array.new if self.windows_of_exposure.nil?
		# set assessments default to empty Array
		self.exposure_assessments = Array.new if self.exposure_assessments.nil?
		# set forms_of_contact default to empty Array
		self.forms_of_contact = Array.new if self.forms_of_contact.nil?
		# set locations_of_use default to empty Array
		self.locations_of_use = Array.new if self.locations_of_use.nil?
		# set frequencies_of_contact default to empty Array
		self.frequencies_of_contact = Array.new if self.frequencies_of_contact.nil?
		# set frequencies_of_use default to empty Array
		self.frequencies_of_use = Array.new if self.frequencies_of_use.nil?
		# set durations_of_use default to empty Array
		self.durations_of_use = Array.new if self.durations_of_use.nil?


		# set doses_assessed default to empty Array
		self.doses_assessed = Array.new if self.doses_assessed.nil?


	end

	searchable do 
		integer :study_id, :references => Study
		string :category
		string :relation_to_child
		string :types, :multiple => true
		string :windows_of_exposure, :multiple => true
		string :exposure_assessments, :multiple => true
		string :forms_of_contact, :multiple => true
		string :locations_of_use, :multiple => true
		string :frequencies_of_contact, :multiple => true
		string :frequencies_of_use, :multiple => true
		string :durations_of_use, :multiple => true


#		string :doses_assessed, :multiple => true


	end

end
