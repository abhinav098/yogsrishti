class Asana < ApplicationRecord
	validates :name, :description, :image, presence: true
end
