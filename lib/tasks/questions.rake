require 'fastercsv'
namespace :app do
namespace :questions do

	task :import => :environment do
		puts "Your are in #{__FILE__}"
	end

end	#	namespace :questions do
end	#	namespace :app do
