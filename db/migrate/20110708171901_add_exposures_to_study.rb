class AddExposuresToStudy < ActiveRecord::Migration
	def self.up
		add_column :studies, :exposures, :text
	end

	def self.down
		remove_column :studies, :exposures
	end
end
