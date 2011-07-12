require 'fastercsv'
namespace :app do
namespace :subjects do

	desc "Import subjects from csv files."
	task :import => :environment do
		puts "Your are in #{__FILE__}"
	end

end	#	namespace :subjects do
end	#	namespace :app do
