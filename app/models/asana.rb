class Asana < ApplicationRecord
	validates :name, :description, :image, presence: true
	searchable do
		text :name
	end

	def xyz(keys)
		search = Sunspot.search(Asana) do
			fulltext keys
		end
		search.results
	end
end
