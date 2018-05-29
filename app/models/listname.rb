class Listname < ApplicationRecord
	has_many :lists
	belongs_to :user, required: false

	def self.getnameid(listname)
		Listname.find_by(name: listname).id
	end

	def self.additem(newitem, listname)
		list = Listname.find_by(name: listname)
		temparr = list.listitems.dup
		temparr << newitem
		list.update(
			listitems: temparr
			)
	end

	def self.deleteitems(items)
		if items.length > 0
			items.each do |item|
				list = List.find_by(id: item)
				list.destroy
			end
		end
	end

end
