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
	has_many :episodes
end

class Product < ActiveRecord::Base
	belongs_to :episode
	belongs_to :company
	has_many :socials
end

class Social < ActiveRecord::Base
	belongs_to :product
end

	Social.delete_all
	Product.delete_all
	Company.delete_all
	Episode.delete_all
	Season.delete_all

	source_list=['https://gist.githubusercontent.com/murtuzakz/7577029c25d9e231f8b4826125f72d93/raw/017b3e31a8aa37ce16ccbc79313930dce5c39cc8/season1.json','https://gist.githubusercontent.com/murtuzakz/f0518a1b8ed3911103d42e322a112bf8/raw/77ac695cb4bf34087fd5160e68135e5a62066219/season2.json','https://gist.githubusercontent.com/murtuzakz/4ca3e8edd3695f4aba600276ac4280a3/raw/74bef5a8e1361c662c9e0efdabd1908ee008f5fc/season3.json','https://gist.githubusercontent.com/murtuzakz/d04d4edcee26916fed616ae150274929/raw/2872831473aaf652b62db8f018d486d8f5019496/season4.json','https://gist.githubusercontent.com/murtuzakz/dc3296f4e276ad251d2fc79a377034b3/raw/dfe5fabddc98c6b0166dae172ccef926c656bc8a/season5.json','https://gist.githubusercontent.com/murtuzakz/ce40648277a1df1259f68f968be42dd4/raw/62576d7d97894f8f5e49fbbd996ba1fa8b117eac/season6.json','https://gist.githubusercontent.com/murtuzakz/4bd887712703ff14c9b0f7c18229b332/raw/d0dd1c59016e2488dcbe0c8e710a1c5df9c3672e/season7.json']
	source_list.each do |season|
		resp = Net::HTTP.get_response(URI.parse(season))
		data = resp.body
		result = JSON.parse(data)
		puts " all reading done-----------------------------------"

		season_object = Season.create(:season=>season)
		result.each do |res|	
			episode_object = Episode.new(:episode_name=>res.first)	
			episode_object.season = season_object
			episode_object.save!	
			
			res.last.each do |key,value|
				company_data = key.slice("company")
				social = key.slice("social")
				key = key.tap{|k| k.delete("social")}
				key = key.tap{|k| k.delete("company")}
				puts "#{company_data.values.flatten.first}"
				product_object = Product.new(key)
				product_object.episode = episode_object
				product_object.socials.build(social.values.flatten.map{|s| {:social=>"#{s}"}})
				product_object.build_company(company_data.values.flatten.first)
				product_object.save!
			end	
		end
	end




		#company_data.values.first.map{|k,v| k.to_sym + "=>" + v })"
		#puts company_data.values.first.map{|k| ":"+k.first+"=>"+k.last}
		#puts "#{m.keys.map{|e| e.to_sym}}"	

		#res.values.each do |product|
		#episode_object = Episode.create(:episode_name=>episode)
		#episode_object.season = season_object
		#res.values.each do |products|
		#products.each do |product|
			#episode_object.products.build(products)
			#puts "#{product['company']}"
 		    #companies << product['company']
			#end
		#end
 		#Company.create(companies.uniq)
		#puts "#{companies.count} and #{companies.uniq.count} and #{companies.empty?} "

