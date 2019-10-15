require 'mysql2'
require 'active_record'
require 'net/http'

conn = ActiveRecord::Base.establish_connection(
	:adapter => "mysql2",
	:host=>"localhost",
	:username=>"root",
	:password=>"root",
	:database=>"sharktank_development")

class Company <ActiveRecord::Base
	has_one :product
end

class Episode <ActiveRecord::Base
	belongs_to :season
	has_many :products
end

class Season <ActiveRecord::Base
	has_many :episode
end

class Product < ActiveRecord::Base
	belongs_to :episode
	belongs_to :company
	has_many :socials
end

class Social < ActiveRecord::Base
	belongs_to :product
end

