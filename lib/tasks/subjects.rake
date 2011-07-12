require 'fastercsv'
namespace :app do
namespace :subjects do

	task :destroy_all => :environment do
		puts "Destroying all subjects."
		Subject.destroy_all
	end

	desc "Destroy and re-import the subjects from csv file."
	task :import => :destroy_all do
		puts "Importing all subjects from csv file."

		#	DO NOT COMMENT OUT THE HEADER LINE OR IT RAISES CRYPTIC ERROR
		(f=FasterCSV.open("CLIC_Sample_data_10-8-2010_LM.csv", 'rb',{
			:headers => true })).each do |line|
			puts "Processing subject line #{f.lineno}:#{line['study_name']}"

			study = Study.find_by_study_name( line['study_name'] )
			raise "Study not found with name:#{line['study_name']}" unless study

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


#			subject = Subject.create({
#				:study => study,
			study.subjects.create!({
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

#break if f.lineno > 100
		end
		puts "Loaded #{pluralize(Subject.count,'subject')}."
	end	#	task :import => :destroy_all do

end	#	namespace :subjects do
end	#	namespace :app do
