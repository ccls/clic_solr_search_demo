require 'fastercsv'
namespace :app do

	task :import => [ :import_subjects, :import_exposures ]

	task :import_exposures => [:destroy_exposures,
		:import_tobacco, :import_pesticides, :import_vitamins]

	task :destroy_exposures => :environment do
		Exposure.destroy_all
	end

	task :destroy_all => :destroy_exposures do
		Study.destroy_all
		Subject.destroy_all
	end

	task :import_vitamins => :environment do
#	"Study","Relation to Child","Preconception","Pregnancy","Trimester","Postnatal","Breastfeeding","Folate/Folic Acid","Vitamin A","Beta-carotene","B-complex Vitamins","Vitamin C","Vitamin E","Vitamin Complex","Iron","Calcium","Zinc","Selenium","Antioxidant Combination","Prenatal","Multi Vitamin","Any Vitamin, Mineral, or Dietary Supplements","Brand Name","Fill in the Blank","Days/Week","Times/Day","Times/Week","Times/Month","Times/Year","Number of Weeks","Number of Months","Number of Years","Ages","Dose Assessed"
#	"Australia-ALL","Mother",1,1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,0,0,1
#	"Brazil-IAL","Mother",0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0


		#	DO NOT COMMENT OUT THE HEADER LINE OR IT RAISES CRYPTIC ERROR
		(f=FasterCSV.open("Vitamin-DB_Mid-level Groupings_101110_HR.csv", 'rb',{
			:headers => true })).each do |line|
			puts "Processing line #{f.lineno}:#{line['Study']}"

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
	end

	task :import_pesticides => :environment do
#	remove this first line
#	,,"Windows of Exposure",,,,,"Type",,,,,,,"Form of Contact",,,,,"Location of Use",,,,,,"Frequency of Contact Assessment",,,,
#	"Study","Relation to Child","Preconception","Pregnancy","Trimester","Postnatal","Breastfeeding","Professional Services","Pesiticides","Herbicides","Fungicides","Insecticides","Rodenticides","Bactericides","Not Specified","Direct Handling","Skin Contact","Respiratory Absorption","Oral Absporption/Ingestion","Not Specified","Household","Neighborhood","School","Workplace","Crops","Not Specified","Open-Ended","<5 times per period/≥ 5 times per period","Absolute Number of Times","Times per Month"
#	"Australia-ALL","Mother",1,1,0,1,0,1,1,1,1,1,1,1,1,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0
#	"Brazil-IAL","Mother",1,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,1,0,1,0,0,0,1,0,1,0,0,0

		#	DO NOT COMMENT OUT THE HEADER LINE OR IT RAISES CRYPTIC ERROR
#		(f=FasterCSV.open("TobaccoMid-levelGroupings_100410_HR.csv", 'rb',{
		(f=FasterCSV.open("Pesticide-DB_Mid-level Groupings_101110_HR.csv", 'rb',{
			:headers => true })).each do |line|
			puts "Processing line #{f.lineno}:#{line['Study']}"

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
	end

	task :import_tobacco => :environment do
#	"Study",
#		"Relation to Child",
#		"Preconception","Pregnancy","Trimester","Postnatal","Breastfeeding","Lifetime","Current",
#		"Cigarettes","Cigars","Pipes","Unspecified",
#		"Cigarettes Per Day","Cigarettes Per Year","Absolute Number of Cigarettes","Yes/No"
#	"AUS-ALL","Mother",0,0,0,0,0,1,0,1,0,0,0,1,0,0,0
#	"Brazil","Mother",1,0,0,0,0,0,0,1,0,0,0,0,0,1,1

		#	DO NOT COMMENT OUT THE HEADER LINE OR IT RAISES CRYPTIC ERROR
		(f=FasterCSV.open("Tobacco-DB_Mid-level Groupings_101110_HR.csv", 'rb',{
			:headers => true })).each do |line|
			puts "Processing line #{f.lineno}:#{line['Study']}"

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
	end

	task :import_subjects => :destroy_all do

		#	DO NOT COMMENT OUT THE HEADER LINE OR IT RAISES CRYPTIC ERROR
		(f=FasterCSV.open("CLIC_Sample_data_10-8-2010_LM.csv", 'rb',{
			:headers => true })).each do |line|
			puts "Processing line #{f.lineno}"

			study = Study.find_or_create_by_study_name({
				:study_name    => line['study_name'],
				:world_region  => line['world_region'],
				:subregion     => line['subregion'],
				:country       => line['country'],
				:study_design  => line['study_design'],
				:ascertainment => line['ascertainment'],
				:recruitment   => line['recruitment'],
				:method_cytogenetic_subtyping => line['method_cytogenetic_subtyping'],
				:location_cytogenetic_subtyping => line['location_cytogenetic_subtyping'],
				:age_group     => line['age_group']
			})

			genotypings = []
			genotypings << 'phase_I_metabolic' if line['genotyping_phase_I_metabolic']
			genotypings << 'phase_II_metabolic' if line['genotyping_phase_II_metabolic']
			genotypings << 'DNA_repair' if line['genotyping_DNA_repair']
			genotypings << 'immune_function' if line['genotyping_immune_function']
			genotypings << 'oxidative_stress' if line['genotyping_oxidative_stress']
			genotypings << 'folate_metabolism' if line['genotyping_folate_metabolism']
			genotypings << 'other' if line['genotyping_other']

			biospecimens = []
			biospecimens << 'DBS' if line['case_DBS'] or line['control_DBS']
			biospecimens << 'BM' if line['case_DBS']
			biospecimens << 'pretreat_blood' if line['case_pretreat_blood']
			biospecimens << 'blood' if line['case_blood'] or line['control_blood']
			biospecimens << 'buccal' if line['case_buccal'] or line['control_buccal']
			biospecimens << 'saliva' if line['control_saliva']
			biospecimens << 'maternal_blood' if line['case_maternal_blood'] or line['control_maternal_blood']
			biospecimens << 'paternal_blood' if line['case_paternal_blood'] or line['control_paternal_blood']
			biospecimens << 'maternal_buccal' if line['case_maternal_buccal'] or line['control_maternal_buccal']
			biospecimens << 'paternal_buccal' if line['case_paternal_buccal'] or line['control_paternal_buccal']
			biospecimens << 'maternal_saliva' if line['control_maternal_saliva']
			biospecimens << 'paternal_saliva' if line['control_paternal_saliva']


			subject = Subject.create({
				:study => study,
				:subid => line['subid'],
				:case_status => line['case_status'],
				:subtype => line['subtype'],
				:biospecimens => biospecimens,
				:genotypings => genotypings,

#	all vals at the moment
				:cytogenetics_t_12_21 => line['cytogenetics_t_12_21'],
				:cytogenetics_inv_16 => line['cytogenetics_inv_16'],
				:cytogenetics_t_1_19 => line['cytogenetics_t_1_19'],
				:cytogenetics_t_8_21 => line['cytogenetics_t_8_21'],
				:cytogenetics_t_9_22 => line['cytogenetics_t_9_22'],
				:cytogenetics_t_15_17 => line['cytogenetics_t_15_17'],
				:cytogenetics_11q23_MLL => line['cytogenetics_11q23_MLL'],
				:cytogenetics_trisomy_5 => line['cytogenetics_trisomy_5'],
				:cytogenetics_trisomy_21 => line['cytogenetics_trisomy_21'],
				:cytogenetics_high_hyperdiploid => line['cytogenetics_high_hyperdiploid'],
				:cytogenetics_low_hyperdiploid => line['cytogenetics_low_hyperdiploid'],
				:cytogenetics_hypodiploid => line['cytogenetics_hypodiploid'],
				:cytogenetics_other => line['cytogenetics_other']
			})

		end

	end

end

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
