class Asana < ApplicationRecord
	validates :name, :description, :image, presence: true
	searchable do
		text :name
	end

	def search(keys)
		search = Sunspot.search(Asana) do
			fulltext keys
		end.results
	end
end
