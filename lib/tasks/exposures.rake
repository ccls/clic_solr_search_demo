require 'fastercsv'
namespace :app do
namespace :exposures do

	desc "Import exposures from csv files."
	task :import => :environment do
		puts "Your are in #{__FILE__}"
	end

end	#	namespace :exposures do
end	#	namespace :app do
