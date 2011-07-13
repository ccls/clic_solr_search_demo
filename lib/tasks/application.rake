require 'fastercsv'
namespace :app do

	task :destroy_all => :environment do
		puts "Destroying all studies, subjects, exposures and questions."
		Study.destroy_all
		Subject.destroy_all
		Exposure.destroy_all
		Question.destroy_all
	end

	task :import_notification do
		puts "Importing studies, subjects, exposures and questions."
	end

	desc "Destroy and re-import the studies, subjects, exposures and questions from csv files."
	task :import => [ :destroy_all, :import_notification,
		'studies:import','subjects:import', 'exposures:import', 'questions:import' ]

end

#	Copied from actionpack/lib/action_view/helpers/text_helper.rb
def pluralize(count, singular, plural = nil)
	"#{count || 0} " + ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
end
