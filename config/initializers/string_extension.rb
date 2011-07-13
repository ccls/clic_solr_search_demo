String.class_eval do
#	surprised this worked
#	basically added the method :name to make sunspot happy
#	def name
#		self.to_s
#	end
	def html_friendly
#		self.downcase.gsub(/[ \-,]/,'_').gsub(/_+/,'_')
		self.downcase.gsub(/\W/,'_').gsub(/_+/,'_')
	end
end
