class Study < ActiveRecord::Base

	has_many :subjects
	has_many :exposures
	has_many :questions

#	serialize :exposures, Hash

#	:exposures=>{
#		'tobacco' => [
#			{
#				'types' => ["Cigarettes","OtherExample"], 
#				'assessments' => ["Per Day"], 
#				'relation' => ["Mother"], 
#				'windows' => ["Lifetime"]
#			}
#		]
#	}

	def to_s
		study_name
	end

#
#	I really, really, really, do not like this.
#	There must be a better way.
#

#	@facetized_exposures = nil
#	def facetized_exposures
#		@facetized_exposures || facetize_exposures
#	end

protected

#	def facetize_exposures
#		@facetized_exposures = {}
#		@facetized_exposures['exposures'] = exposures.keys
#		exposures.keys.each do |set|	#	'tobacco',...
#			#	['types', 'assessments', 'relation', 'windows']
#			attrs = exposures[set].collect(&:keys).flatten.uniq
#			@facetized_exposures["exposures:#{set}"] = attrs
#			exposures[set].each do |exposure|
#				attrs.each do |attr|
##					('exposures','tobacco','types',exposure,['assessments','relation','windows'])
#					serialize_exposure('exposures',set,attr,exposure,attrs-[attr])
#				end
#			end
#		end
##		@facetized_exposures.keys.sort.each do |key|
##			puts "#{key} = #{@facetized_exposures[key].uniq.inspect}"
##		end
#		@facetized_exposures
#	end
#
#	def serialize_exposure(*args)
#		sibling_attrs = args.pop
#		exposure = args.pop
#		values = exposure[args.last]
#		unless values.empty?
#			@facetized_exposures["#{args.join(':')}"] ||= []
#			@facetized_exposures["#{args.join(':')}"] += values
#			values.each do |value|
#				unless sibling_attrs.empty?
#					new_args = (args.dup + [value] )
#					@facetized_exposures["#{new_args.join(':')}"] ||= []
#					@facetized_exposures["#{new_args.join(':')}"] += sibling_attrs
#					sibling_attrs.each do |attr|
#						serialize_exposure(new_args,attr,exposure,sibling_attrs-[attr])
#					end
#				end
#			end
#		end
#	end
#
#	# can't use macro style setup for after_find or after_initialize
#	def after_initialize
#		# set exposures default to empty Hash
#		self.exposures = Hash.new if self.exposures.nil?
#	end

end
