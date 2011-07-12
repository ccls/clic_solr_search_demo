namespace :app do
namespace :studies do

	task :destroy_all => :environment do
		puts "Destroying all studies."
		Study.destroy_all
	end

	task :import => :destroy_all do
		ENV['FIXTURES'] = 'studies'
		puts "Loading fixtures for #{ENV['FIXTURES']}"
		Rake::Task["db:fixtures:load"].invoke
		Rake::Task["db:fixtures:load"].reenable
		puts "Loaded #{pluralize(Study.count,'study')}."
	end

end	#	namespace :studies do
end	#	namespace :app do
