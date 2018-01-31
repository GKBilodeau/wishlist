class List < ApplicationRecord
	belongs_to :user, required: false

	def self.getlist(id)
		where(userid: id)
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

