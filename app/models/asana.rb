class Asana < ApplicationRecord
	validates :name, :description, :image, presence: true
	searchable do
		text :name
	end
end
