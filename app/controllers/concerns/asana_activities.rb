module AsanaActivities
	def search_asana
	 	search = Sunspot.search(Asana) do 
								fulltext params[:search]
							end.results		
	end
end							