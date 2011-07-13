require 'fastercsv'
namespace :app do
namespace :questions do

	desc "Destroy existing questions."
	task :destroy_all => :environment do
		puts "Destroying all questions"
		Question.destroy_all
	end

	task :import_notification do
		puts "Importing all questions."
	end

	desc "Import questions from csv files."
	task :import => :destroy_all do
		puts "Importing all questions."
		Dir['DB_DataDict_DB_110410_CM-*.csv'].each do |csv|
			puts "Processing file:#{csv}"
			#	DO NOT COMMENT OUT THE HEADER LINE OR IT RAISES CRYPTIC ERROR
			(f=FasterCSV.open(csv, 'rb',{
				:headers => true })).each do |line|
				puts "Processing question line #{f.lineno}:#{line['Study Name']}"

#	"Study Name","World Region","Country","Sub region","Relation","Time Period","Sub Categories","Exposure Categories","Level of Assessment","Question Type","Question","Sub Question","Primary Response","Secondary Question","Secondary Response","Tertiary Question","Tertiary Response","Quaternary Question","Standard","Data Available?"
#	"ADELE (France)","Europe","France",,"Mother","Preconception",,"Alcohol",,,,,,,,,,,"glass","Data not collected for preconception exposure"
#	"ADELE (France)","Europe","France",,"Mother","Pregnancy",,"Alcohol",,"fill in blank","How often did you drink alcohol during your pregnancy?",,,,,,,,"glass",

				study = Study.find_by_study_name(line['Study Name'])
				raise "Can't find study:#{line['Study Name']}" unless study

				study.questions.create!({
					:relation             => line["Relation to Child"],
					:time_period          => line['Time Period'],
					:category             => line['Exposure Categories'],
					:subcategory          => line['Sub Categories'],
					:level_of_assessment  => line['Level of Assessment'],
					:question_type        => line['Question Type'],
					:primary_question     => line['Question'],
					:primary_subquestion  => line['Sub Question'],
					:primary_response     => line['Primary Response'],
					:secondary_question   => line['Secondary Question'],
					:secondary_response   => line['Secondary Response'],
					:tertiary_question    => line['Tertiary Question'],
					:tertiary_response    => line['Tertiary Response'],
#	NOTE not on all sheets and when is, is not always spelled the same
#					:quarternary_question => line['Quartary Question'],
#					:quarternary_response => line['Quartary Response'],
#	NOTE also not on all
					:answers              => line['Answers'],
#	NOTE also not on all
					:time_period_notes    => line['Time Period Notes'],
					:standard             => line['Standard'],
					:data_available       => line['Data Available?']
				})

#break if f.lineno > 1
			end	#	(f=FasterCSV.open(csv, 'rb',{

		end	#	Dir['DB_DataDict_DB_110410_CM-*.csv'].each do |csv|
		puts "Loaded #{pluralize(Question.count,'question')}."
	end	#	task :import => :destroy_all do

end	#	namespace :questions do
end	#	namespace :app do
