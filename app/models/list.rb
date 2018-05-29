class List < ApplicationRecord
	belongs_to :user, required: false
	belongs_to :listname, required: false

	def self.currentlist(id)
		where(listnameid: id).order("id")		
	end

	def self.getlist(items)
		list = []
		items.each do |item|
			list << List.find_by(id: item)
		end
		list
	end

	def self.buy(itemname,userid)
		if itemname.nil? == false
			item = List.find_by(name: itemname)
			item.update(
				purchased: true,
				purchasedby: userid
				)
		end
	end

	def self.return(itemid)
		itemid = itemid.to_i
		item = List.find_by(id: itemid)
		item.update(
			purchased: false,
			purchasedby: nil
			)
	end

end

