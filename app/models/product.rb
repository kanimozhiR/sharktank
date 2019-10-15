class Product < ApplicationRecord
  has_many :socials
  belongs_to :company
  belongs_to :episode
end
