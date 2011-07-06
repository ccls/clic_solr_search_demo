require 'fastercsv'
namespace :app do

	task :destroy_all => :environment do
		Study.destroy_all
		Subject.destroy_all
	end

#	task :import => :environment do
	task :import => :destroy_all do

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
				:age_group     => line['age_group']
			})

			subject = Subject.create({
				:study => study,
				:subid => line['subid'],
				:case_status => line['case_status'],
				:method_cytogenetic_subtyping => line['method_cytogenetic_subtyping'],
				:location_cytogenetic_subtyping => line['location_cytogenetic_subtyping'],
				:subtype => line['subtype'],
				:case_DBS => line['case_DBS'],
				:case_BM => line['case_BM'],
				:case_pretreat_blood => line['case_pretreat_blood'],
				:case_blood => line['case_blood'],
				:case_buccal => line['case_buccal'],
				:case_maternal_blood => line['case_maternal_blood'],
				:case_paternal_blood => line['case_paternal_blood'],
				:case_maternal_buccal => line['case_maternal_buccal'],
				:case_paternal_buccal => line['case_paternal_buccal'],
				:control_DBS => line['control_DBS'],
				:control_blood => line['control_blood'],
				:control_buccal => line['control_buccal'],
				:control_saliva => line['control_saliva'],
				:control_maternal_blood => line['control_maternal_blood'],
				:control_paternal_blood => line['control_paternal_blood'],
				:control_maternal_buccal => line['control_maternal_buccal'],
				:control_paternal_buccal => line['control_paternal_buccal'],
				:control_maternal_saliva => line['control_maternal_saliva'],
				:control_paternal_saliva => line['control_paternal_saliva'],
				:genotyping_phase_I_metabolic => line['genotyping_phase_I_metabolic'],
				:genotyping_phase_II_metabolic => line['genotyping_phase_II_metabolic'],
				:genotyping_DNA_repair => line['genotyping_DNA_repair'],
				:genotyping_immune_function => line['genotyping_immune_function'],
				:genotyping_oxidative_stress => line['genotyping_oxidative_stress'],
				:genotyping_folate_metabolism => line['genotyping_folate_metabolism'],
				:genotyping_other => line['genotyping_other'],
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
