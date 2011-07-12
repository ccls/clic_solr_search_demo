require 'fastercsv'
namespace :app do
namespace :exposures do

	desc "Destroy all the existing exposures."
	task :destroy_all => :environment do
		puts "Destroying all exposures"
		Exposure.destroy_all
	end

	task :import_notification do
		puts "Importing all tobacco, pesticide and vitamin exposures."
	end

	desc "Destroy and re-import the exposures from csv files."
	task :import => [:destroy_all, :import_notification,
		:import_tobacco, :import_pesticides, :import_vitamins] do
		puts "Loaded #{pluralize(Exposure.count,'exposure')}."
	end

	task :import_vitamins do
		puts "Importing vitamin exposures."
#	"Study","Relation to Child","Preconception","Pregnancy","Trimester","Postnatal","Breastfeeding","Folate/Folic Acid","Vitamin A","Beta-carotene","B-complex Vitamins","Vitamin C","Vitamin E","Vitamin Complex","Iron","Calcium","Zinc","Selenium","Antioxidant Combination","Prenatal","Multi Vitamin","Any Vitamin, Mineral, or Dietary Supplements","Brand Name","Fill in the Blank","Days/Week","Times/Day","Times/Week","Times/Month","Times/Year","Number of Weeks","Number of Months","Number of Years","Ages","Dose Assessed"
#	"Australia-ALL","Mother",1,1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,0,0,1
#	"Brazil-IAL","Mother",0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0


		#	DO NOT COMMENT OUT THE HEADER LINE OR IT RAISES CRYPTIC ERROR
		(f=FasterCSV.open("DB_Mid-level Groupings_101110_HR-Vitamin.csv", 'rb',{
			:headers => true })).each do |line|
			puts "Processing exposure line #{f.lineno}:#{line['Study']}"

			study = Study.find_by_study_name(line['Study'])
			raise "Can't find study:#{line['Study']}" unless study

			study.exposures.create!({
				:category            => 'vitamins',
				:relation_to_child   => line["Relation to Child"],
				:windows_of_exposure => windows_of_exposure(line),
				:types               => vitamin_types(line),
				:frequencies_of_use  => frequencies_of_use(line),
				:durations_of_use    => durations_of_use(line)
#				:dose_assessed       => ?????
			})

#break if f.lineno > 1
		end
	end	#	task :import_vitamins do

	task :import_pesticides do
		puts "Importing pesticide exposures."
#	remove this first line
#	,,"Windows of Exposure",,,,,"Type",,,,,,,"Form of Contact",,,,,"Location of Use",,,,,,"Frequency of Contact Assessment",,,,
#	"Study","Relation to Child","Preconception","Pregnancy","Trimester","Postnatal","Breastfeeding","Professional Services","Pesiticides","Herbicides","Fungicides","Insecticides","Rodenticides","Bactericides","Not Specified","Direct Handling","Skin Contact","Respiratory Absorption","Oral Absporption/Ingestion","Not Specified","Household","Neighborhood","School","Workplace","Crops","Not Specified","Open-Ended","<5 times per period/≥ 5 times per period","Absolute Number of Times","Times per Month"
#	"Australia-ALL","Mother",1,1,0,1,0,1,1,1,1,1,1,1,1,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0
#	"Brazil-IAL","Mother",1,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,1,0,1,0,0,0,1,0,1,0,0,0

		#	DO NOT COMMENT OUT THE HEADER LINE OR IT RAISES CRYPTIC ERROR
#		(f=FasterCSV.open("TobaccoMid-levelGroupings_100410_HR.csv", 'rb',{
		(f=FasterCSV.open("DB_Mid-level Groupings_101110_HR-Pesticide.csv", 'rb',{
			:headers => true })).each do |line|
			puts "Processing exposure line #{f.lineno}:#{line['Study']}"

			study = Study.find_by_study_name(line['Study'])
			raise "Can't find study:#{line['Study']}" unless study

			study.exposures.create!({
				:category            => 'pesticides',
				:relation_to_child   => line["Relation to Child"],
				:windows_of_exposure => windows_of_exposure(line),
				:types               => pesticide_types(line),
				:forms_of_contact    => forms_of_contact(line),
				:locations_of_use    => locations_of_use(line),
				:frequencies_of_contact => frequencies_of_contact(line)
			})

#break if f.lineno > 1
		end
	end	#	task :import_pesticides do

	task :import_tobacco do
		puts "Importing tobacco exposures."
#	"Study",
#		"Relation to Child",
#		"Preconception","Pregnancy","Trimester","Postnatal","Breastfeeding","Lifetime","Current",
#		"Cigarettes","Cigars","Pipes","Unspecified",
#		"Cigarettes Per Day","Cigarettes Per Year","Absolute Number of Cigarettes","Yes/No"
#	"AUS-ALL","Mother",0,0,0,0,0,1,0,1,0,0,0,1,0,0,0
#	"Brazil","Mother",1,0,0,0,0,0,0,1,0,0,0,0,0,1,1

		#	DO NOT COMMENT OUT THE HEADER LINE OR IT RAISES CRYPTIC ERROR
		(f=FasterCSV.open("DB_Mid-level Groupings_101110_HR-Tobacco.csv", 'rb',{
			:headers => true })).each do |line|
			puts "Processing exposure line #{f.lineno}:#{line['Study']}"

			study = Study.find_by_study_name(line['Study'])
			raise "Can't find study:#{line['Study']}" unless study

			study.exposures.create!({
				:category             => 'tobacco',
				:relation_to_child    => line["Relation to Child"],
				:windows_of_exposure  => windows_of_exposure(line),
				:types                => tobacco_types(line),
				:exposure_assessments => tobacco_assessments(line)
			})

#break if f.lineno > 1
		end
	end	#	task :import_tobacco do

end	#	namespace :exposures do
end	#	namespace :app do


#	could possibly merge all these into a single method

def windows_of_exposure(line)
	fields = %w( Preconception Pregnancy Trimester Postnatal Breastfeeding Lifetime Current )
	fields.select do |f|
		line[f] == '1'
	end
end

def tobacco_types(line)
	fields = %w( Cigarettes Cigars Pipes Unspecified )
	fields.select do |f|
		line[f] == '1'
	end
end

def vitamin_types(line)
	fields = ['Folate/Folic Acid','Vitamin A','Beta-carotene','B-complex Vitamins','Vitamin C','Vitamin E','Vitamin Complex','Iron','Calcium','Zinc','Selenium','Antioxidant Combination','Prenatal','Multi Vitamin','Any Vitamin, Mineral, or Dietary Supplements','Brand Name']
	fields.select do |f|
		line[f] == '1'
	end
end

def pesticide_types(line)
	fields = ['Professional Services','Pesiticides','Herbicides','Fungicides','Insecticides','Rodenticides','Bactericides']
	fields.select do |f|
		line[f] == '1'
	end
end

def tobacco_assessments(line)
	fields = [ 'Cigarettes Per Day', 'Cigarettes Per Year',
		'Absolute Number of Cigarettes', 'Yes/No']
	fields.select do |f|
		line[f] == '1'
	end
end

def frequencies_of_use(line)
	fields = ['Fill in the Blank','Days/Week',
		'Times/Day','Times/Week','Times/Month','Times/Year']
	fields.select do |f|
		line[f] == '1'
	end
end

def durations_of_use(line)
	fields = ['Number of Weeks','Number of Months','Number of Years','Ages']
	fields.select do |f|
		line[f] == '1'
	end
end

def forms_of_contact(line)
	fields = ['Not Specified','Direct Handling','Skin Contact','Respiratory Absorption','Oral Absporption/Ingestion']
	fields.select do |f|
		line[f] == '1'
	end
end

def locations_of_use(line)
	fields = ['Not Specified','Household','Neighborhood','School','Workplace','Crops']
	fields.select do |f|
		line[f] == '1'
	end
end

def frequencies_of_contact(line)
	fields = ['Not Specified','Open-Ended','<5 times per period/≥ 5 times per period','Absolute Number of Times','Times per Month']
	fields.select do |f|
		line[f] == '1'
	end
end
