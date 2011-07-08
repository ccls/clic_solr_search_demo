require 'fastercsv'
namespace :app do

	task :destroy_all => :environment do
		Study.destroy_all
		Subject.destroy_all
	end

#	task :import_groupings do	#=> :environment do
	task :import_groupings => :environment do
#	"Study_name",
#		"Relation to Child",
#		"Preconception","Pregnancy","Trimester","Postnatal","Breastfeeding","Lifetime","Current",
#		"Cigarettes","Cigars","Pipes","Unspecified",
#		"Cigarettes Per Day","Cigarettes Per Year","Absolute Number of Cigarettes","Yes/No"
#	"AUS-ALL","Mother",0,0,0,0,0,1,0,1,0,0,0,1,0,0,0
#	"Brazil","Mother",1,0,0,0,0,0,0,1,0,0,0,0,0,1,1

		LIVE = false	#true	#	false
		studies = []

		if LIVE
			Study.update_all("exposures = '--- {}'")
##		Study.update_all(:exposures => {})	#	sets exposures to NULL, but still works
##		exit
		end

		#	DO NOT COMMENT OUT THE HEADER LINE OR IT RAISES CRYPTIC ERROR
		(f=FasterCSV.open("TobaccoMid-levelGroupings_100410_HR.csv", 'rb',{
			:headers => true })).each do |line|
			puts "Processing line #{f.lineno}:#{line['Study_name']}"

			study = {}
			if LIVE
				study = Study.find_by_study_name(line['Study_name'])
				raise "Can't find study:#{line['Study_name']}" unless study
				studies << study
			else
				if studies.collect{|s|s[:name]}.include?(line['Study_name'])
					study = studies.find{|s| s[:name] == line['Study_name']}
				else
					study = { :name => line['Study_name'] }
					studies << study
				end
			end

			windows = []
			windows.push('Preconception') if line['Preconception'] == '1'
			windows.push('Pregnancy') if line['Pregnancy'] == '1'
			windows.push('Trimester') if line['Trimester'] == '1'
			windows.push('Postnatal') if line['Postnatal'] == '1'
			windows.push('Breastfeeding') if line['Breastfeeding'] == '1'
			windows.push('Lifetime') if line['Lifetime'] == '1'
			windows.push('Current') if line['Current'] == '1'

			types = []
			types.push('Cigarettes') if line['Cigarettes'] == '1'
			types.push('Cigars') if line['Cigars'] == '1'
			types.push('Pipes') if line['Pipes'] == '1'
			types.push('Unspecified') if line['Unspecified'] == '1'

			assessments = []
			assessments.push('Cigarettes Per Day') if line['Cigarettes Per Day'] == '1'
			assessments.push('Cigarettes Per Year') if line['Cigarettes Per Year'] == '1'
			assessments.push('Absolute Number of Cigarettes') if line['Absolute Number of Cigarettes'] == '1'
			assessments.push('Yes/No') if line['Yes/No'] == '1'

			if LIVE
				study.exposures['tobacco'] ||= []
				study.exposures['tobacco'].push({
					'relation'    => [line["Relation to Child"]],
					'windows'     => windows,
					'assessments' => assessments,
					'types'       => types
				})
				study.save
			else
				study[:exposures] ||= []
				study[:exposures].push({
					:relation    => [line["Relation to Child"]],
					:windows     => windows,
					:assessments => assessments,
					:types       => types
				})
			end
#break if f.lineno > 1
		end

exit

#
#
#
#		Prepping for facet.pivot ?
#
#
#

##	studies: [{:exposures=>[{:types=>["Cigarettes","OtherExample"], :assessments=>["Per Day"], :relation=>"Mother", :windows=>["Lifetime"]}], :name=>"AUS-ALL"}]
		studies.each do |study|
			puts study[:name]
			puts "exposure = [tobacco]"
##		study: {:exposures=>[{:types=>["Cigarettes","OtherExample"], :assessments=>["Per Day"], 
##							:relation=>"Mother", :windows=>["Lifetime"]}], :name=>"AUS-ALL"}
			four_keys = ['types', 'assessments', 'relation', 'windows']
##				four_keys: [:types, :assessments, :relation, :windows]
					puts "exposure:tobacco = #{four_keys.inspect}"
##				=> exposure:tobacco = [types,assessments,relation,windows]
			study[:exposures].each do |exposure|
##			exposure: {:types=>["Cigarettes","OtherExample"], :assessments=>["Per Day"], 
##									:relation=>"Mother", :windows=>["Lifetime"]}
				four_keys.each do |four_key|
##					four_key: :types
					four_values = exposure[four_key]
##					four_values: ["Cigarettes","OtherExample"]
					puts "exposure:tobacco:#{four_key} = #{four_values.inspect}"
##				=> exposure:tobacco:types = [Cigarettes,OtherExample]
					four_values.each do |four_value|
##						four_value: "Cigarettes"
						three_keys = four_keys - [ four_key ]    #	[:assessments, :relation, :windows]
						puts "exposure:tobacco:#{four_key}:#{four_value} = #{three_keys.inspect}"
##					=> exposure:tobacco:types:Cigarettes = [assessments,relation,windows]
##						three_keys: [:assessments, :relation, :windows]
						three_keys.each do |three_key|
##							three_key: :assessments
							three_values = exposure[three_key]
							puts "exposure:tobacco:#{four_key}:#{four_value}:#{three_key} = #{three_values.inspect}"
##						=> exposure:tobacco:types:Cigarettes:assessments = [Per Day]
##							three_values: ["Per Day"]
							three_values.each do |three_value|
#									three_value: "Per Day"
#
								two_keys = three_keys - [ three_key ]  #	[:relation, :windows]
								puts "exposure:tobacco:#{four_key}:#{four_value}:#{three_key}:#{three_value} = #{two_keys.inspect}"
##							=> exposure:tobacco:types:Cigarettes:assessments:Per Day = [relation,windows]
								two_keys.each do |two_key|
									two_values = exposure[two_key]
									puts "exposure:tobacco:#{four_key}:#{four_value}:#{three_key}:#{three_value}:#{two_key} = #{two_values.inspect}"
##								=> exposure:tobacco:types:Cigarettes:assessments:Per Day:relation = [Mother]
									two_values.each do |two_value|
										one_keys = two_keys - [ two_key ]     #	[:windows]
										puts "exposure:tobacco:#{four_key}:#{four_value}:#{three_key}:#{three_value}:#{two_key}:#{two_value} = #{one_keys.inspect}"
##									=> exposure:tobacco:types:Cigarettes:assessments:Per Day:relation:Mother = [windows]
										one_keys.each do |one_key|
											one_values = exposure[one_key]
											puts "exposure:tobacco:#{four_key}:#{four_value}:#{three_key}:#{three_value}:#{two_key}:#{two_value}:#{one_key} = #{one_values.inspect}"
##										=> exposure:tobacco:types:Cigarettes:assessments:Per Day:relation:Mother:windows = [Lifetime]
#											one_values.each do |one_value|
#
#	don't think that I need to go this far
#
#											end	#		one_values.each do |one_value|
										end	#		one_keys.each do |one_key|
									end	#		two_values = exposure[two_value]
								end	#		two_keys.each do |two_key|
							end	#		three_values = exposure[three_value]
						end #		three_keys.each do |three_key|
					end	#		four_values.each do |four_value|
				end #		four_keys.each do |four_key|
			end #		study[:exposures].each do |exposure|
		end	#		studies.each do |study|

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

#	possible study related rather than subject related
				:method_cytogenetic_subtyping => line['method_cytogenetic_subtyping'],
				:location_cytogenetic_subtyping => line['location_cytogenetic_subtyping'],

#	remove case_/control_ prefix and merge
#	
#				:case_DBS => line['case_DBS'],
#				:case_BM => line['case_BM'],
#				:case_pretreat_blood => line['case_pretreat_blood'],
#				:case_blood => line['case_blood'],
#				:case_buccal => line['case_buccal'],
#				:case_maternal_blood => line['case_maternal_blood'],
#				:case_paternal_blood => line['case_paternal_blood'],
#				:case_maternal_buccal => line['case_maternal_buccal'],
#				:case_paternal_buccal => line['case_paternal_buccal'],
#				:control_DBS => line['control_DBS'],
#				:control_blood => line['control_blood'],
#				:control_buccal => line['control_buccal'],
#				:control_saliva => line['control_saliva'],
#				:control_maternal_blood => line['control_maternal_blood'],
#				:control_paternal_blood => line['control_paternal_blood'],
#				:control_maternal_buccal => line['control_maternal_buccal'],
#				:control_paternal_buccal => line['control_paternal_buccal'],
#				:control_maternal_saliva => line['control_maternal_saliva'],
#				:control_paternal_saliva => line['control_paternal_saliva'],
#
#	demo has these all nested
# make genotyping an array with values as [phase_I_metabolic, ....] ?
#	only used to flag true so ....
#	study has many genotypings?
#	same for cytogenetics? actually has a value as opposed to a flag, so many not work
#	may be able to do this with biospecimens as are also just flags and not arrays
#
#	WARNING: may be subject and not study related as counts are not consistent (for both genotyping and biospecimens)
#
#	genotyping has only a name 'dna_repair', 'folate_metabolism', .... ?
#+----------------+-------------------------------+-------+----------+
#| label          | variable                      | value | count(*) |
#+----------------+-------------------------------+-------+----------+
#| AUS-ALL        | genotyping_DNA_repair         | 1     |      687 |
#| CCLS           | genotyping_DNA_repair         | 1     |     1635 |
#| France - ADELE | genotyping_DNA_repair         | 1     |      336 |
#| Korea          | genotyping_DNA_repair         | 1     |      520 |
#| Qc-ALL         | genotyping_DNA_repair         | 1     |      870 |
#| Quebec         | genotyping_DNA_repair         | 1     |      976 |
#| NULL           | genotyping_DNA_repair         | 1     |     5024 |
#| NULL           | genotyping_DNA_repair         | NULL  |     5024 |
#| AUS-ALL        | genotyping_folate_metabolism  | 1     |      687 |
#| Brazil         | genotyping_folate_metabolism  | 1     |      238 |
#| CCLS           | genotyping_folate_metabolism  | 1     |     1635 |
#| UKCCS          | genotyping_folate_metabolism  | 1     |     1125 |
#| NULL           | genotyping_folate_metabolism  | 1     |     3685 |
#| NULL           | genotyping_folate_metabolism  | NULL  |     3685 |
#| AUS-ALL        | genotyping_immune_function    | 1     |      687 |
#| CCLS           | genotyping_immune_function    | 1     |     1635 |
#| France - ADELE | genotyping_immune_function    | 1     |      336 |
#| Korea          | genotyping_immune_function    | 1     |      520 |
#| Manchester, UK | genotyping_immune_function    | 1     |      422 |
#| Quebec         | genotyping_immune_function    | 1     |      976 |
#| UKCCS          | genotyping_immune_function    | 1     |     1125 |
#| NULL           | genotyping_immune_function    | 1     |     5701 |
#| NULL           | genotyping_immune_function    | NULL  |     5701 |
#| Brazil         | genotyping_other              | 1     |      238 |
#| Korea          | genotyping_other              | 1     |      520 |
#| Qc-ALL         | genotyping_other              | 1     |      870 |
#| Quebec         | genotyping_other              | 1     |      976 |
#| NULL           | genotyping_other              | 1     |     2604 |
#| NULL           | genotyping_other              | NULL  |     2604 |
#| AUS-ALL        | genotyping_oxidative_stress   | 1     |      687 |
#| CCLS           | genotyping_oxidative_stress   | 1     |     1635 |
#| Korea          | genotyping_oxidative_stress   | 1     |      520 |
#| Qc-ALL         | genotyping_oxidative_stress   | 1     |      870 |
#| Quebec         | genotyping_oxidative_stress   | 1     |      976 |
#| NULL           | genotyping_oxidative_stress   | 1     |     4688 |
#| NULL           | genotyping_oxidative_stress   | NULL  |     4688 |
#| AUS-ALL        | genotyping_phase_II_metabolic | 1     |      687 |
#| Brazil         | genotyping_phase_II_metabolic | 1     |      238 |
#| CCLS           | genotyping_phase_II_metabolic | 1     |     1635 |
#| France - ADELE | genotyping_phase_II_metabolic | 1     |      336 |
#| Qc-ALL         | genotyping_phase_II_metabolic | 1     |      870 |
#| Quebec         | genotyping_phase_II_metabolic | 1     |      976 |
#| NULL           | genotyping_phase_II_metabolic | 1     |     4742 |
#| NULL           | genotyping_phase_II_metabolic | NULL  |     4742 |
#| AUS-ALL        | genotyping_phase_I_metabolic  | 1     |      687 |
#| Brazil         | genotyping_phase_I_metabolic  | 1     |      238 |
#| CCLS           | genotyping_phase_I_metabolic  | 1     |     1635 |
#| France - ADELE | genotyping_phase_I_metabolic  | 1     |      336 |
#| Korea          | genotyping_phase_I_metabolic  | 1     |      520 |
#| Qc-ALL         | genotyping_phase_I_metabolic  | 1     |      870 |
#| Quebec         | genotyping_phase_I_metabolic  | 1     |      976 |
#| NULL           | genotyping_phase_I_metabolic  | 1     |     5262 |
#| NULL           | genotyping_phase_I_metabolic  | NULL  |     5262 |
#| NULL           | NULL                          | NULL  |    31706 |
#+----------------+-------------------------------+-------+----------+

#				:genotyping_phase_I_metabolic => line['genotyping_phase_I_metabolic'],
#				:genotyping_phase_II_metabolic => line['genotyping_phase_II_metabolic'],
#				:genotyping_DNA_repair => line['genotyping_DNA_repair'],
#				:genotyping_immune_function => line['genotyping_immune_function'],
#				:genotyping_oxidative_stress => line['genotyping_oxidative_stress'],
#				:genotyping_folate_metabolism => line['genotyping_folate_metabolism'],
#				:genotyping_other => line['genotyping_other'],

#	:genotypings => [ blah, blah, blah ],

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
