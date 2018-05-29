class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         has_many :lists
         has_many :listnames

        def self.search(search, userid, userperms)
        	where("id != #{userid} AND name ILIKE ?","%#{search}%")
        end

        def self.perm_mod(perms, userid)
         	current = User.find_by(id: userid)
         	perms = perms.map(&:to_i)
         	temparr = current.permissions.dup
         	perms.each do |perm|
         		unless temparr.include? perm
         			temparr << perm
         		end
           	end
           	current.update(
           		permissions: temparr
           	)
        end

        def self.mylists_mod(perms, listname)
            list = Listname.find_by(name: listname).id
        	perms = perms.map(&:to_i)
        	perms.each do |perm|
        		givento = User.find_by(id: perm)
        		temparr = givento.mylists.dup
        		unless temparr.include? list
        			temparr << list
        		end
        		givento.update(
        			mylists: temparr
        		)
        	end
        end

        def self.fill(permissions)
        	names = []
        	permissions.each do |perm|
        		shopping_for = User.find_by(id: perm)
        		names << shopping_for.name
        	end
        	names
        end

        def self.wishlists(mylists)
        	names = []
        	mylists.each do |list|
        		wishlist = Listname.find_by(id: list)
        		person = User.find_by(id: wishlist.userid)
                names << [person.name,wishlist.name]
        	end
        	names
        end

        def self.perm_del(permissions,userid)
        	perms = []
        	current = User.find_by(id: userid)
        	temparr = current.permissions.dup
        	permissions.each do |perm|
        		person = User.find_by(name: perm)
        		perms << person.id
        	end
        	perms.each do |nameid|
        		if temparr.include? nameid
        			temparr.delete(nameid)
        		end
        	end
           	current.update(
           		permissions: temparr
           	)
        end

        def self.mylist_del(permissions,userid)
            permissions.each do |perm|
                takefrom = User.find_by(name: perm)
                temparr = takefrom.mylists.dup
                temparr.delete(userid)
                takefrom.update(
                    mylists: temparr
                    )
            end
        end

end