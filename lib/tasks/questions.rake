require 'fastercsv'
namespace :app do
namespace :questions do

	desc "Destroy existing questions."
	task :destroy_all => :environment do
		puts "Destroying all questions"
		Question.destroy_all
	end

	desc "Import questions from csv files."
	task :import => [:destroy_all,:import_alcohol]

#
#	don't call individually ???
#

	task :import_alcohol do
		puts "Importing alcohol questions"

		#	DO NOT COMMENT OUT THE HEADER LINE OR IT RAISES CRYPTIC ERROR
		(f=FasterCSV.open("DB_DataDict_DB_110410_CM-Alcohol.csv", 'rb',{
			:headers => true })).each do |line|
			puts "Processing line #{f.lineno}:#{line['Study']}"

#	"Study Name","World Region","Country","Sub region","Relation","Time Period","Sub Categories","Exposure Categories","Level of Assessment","Question Type","Question","Sub Question","Primary Response","Secondary Question","Secondary Response","Tertiary Question","Tertiary Response","Quaternary Question","Standard","Data Available?"
#	"ADELE (France)","Europe","France",,"Mother","Preconception",,"Alcohol",,,,,,,,,,,"glass","Data not collected for preconception exposure"
#	"ADELE (France)","Europe","France",,"Mother","Pregnancy",,"Alcohol",,"fill in blank","How often did you drink alcohol during your pregnancy?",,,,,,,,"glass",

			study = Study.find_by_study_name(line['Study Name'])
			raise "Can't find study:#{line['Study Name']}" unless study

			study.questions.create!({
				:relation            => line["Relation to Child"],
				:time_period         => line['Time Period'],
				:category            => line['Exposure Categories'],
				:subcategory         => line['Sub Categories'],
				:level_of_assessment => line['Level of Assessment'],
#	TODO change names
				:type                => line['Question Type'],
				:body                => line['Question'],
				:subquestion         => line['Sub Question'],
				:primary_response    => line['Primary Response'],
				:secondary_question  => line['Secondary Question'],
				:secondary_response  => line['Secondary Response'],
				:tertiary_question   => line['Tertiary Question'],
				:tertiary_response   => line['Tertiary Response'],
#	NOTE not on all sheets and when is, is not always spelled the same
#				:quartary_question   => line['Quartary Question'],
#				:quartary_response   => line['Quartary Response'],
#	NOTE also not on all
#				:answers             => line['xyz'],
#	NOTE also not on all
#				:time_period_notes   => line['xyz'],
				:standard            => line['Standard'],
				:data_available      => line['Data Available?']
			})

#break if f.lineno > 1
		end

	end

end	#	namespace :questions do
end	#	namespace :app do
