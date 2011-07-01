class SearchesController < ApplicationController

	def show
#
#	should devise some way to determine if the sunspot server is actually running
#
		@search = Sunspot.search(Book,Chapter,Verse) do
			keywords params[:q]
#	undefined method `name' for "Book":String 
#	where Book is params[:class]
#	either constantize or create String#name method
#	both seem to make Sunspot happy
			with(:class, params[:class].constantize) if params[:class]
			facet :class 
			with(:author, params[:author_s]) if params[:author_s]
			facet :author	#	seems to work even though just in book

#	kinda pointless, but nice to know it works
#			facet :chapters_count
#			facet :verses_count

			order_by :created_at, :asc
			paginate :page => params[:page]
		end
	end

end
