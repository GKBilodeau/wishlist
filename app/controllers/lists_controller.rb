class ListsController < ApplicationController
	def home
		if current_user
			redirect_to "/lists/index"
		end
	end

	def index
		@listnames = Listname.where(userid: current_user.id)
		@permissions = User.fill(current_user.permissions)
		@mylists =  User.wishlists(current_user.mylists)
		@listname = Listname.where(userid: current_user.id)
	end

	def newitem
		
	end

	def newlist
		
	end

	def create
		if params[:item_name]
			newitem = List.create(
		    name: params[:item_name],
		    description: params[:item_description],
		    stores: params[:where_to_find],
		    userid: current_user.id,
		    listnameid: Listname.getnameid(params[:listname])
		    )
		    Listname.additem(newitem.id,params[:listname])
		        if params[:multiple_purchases] == "1"
		        	newitem.update_attributes(:multiplepurchases => true)
		        end
		elsif params[:list_name]
	        Listname.create(
	        name: params[:list_name],
	        userid: current_user.id
	        )
        end	
        redirect_to "/lists/index"
	end

	def edit
		@list = List.find_by(id: params[:id])
	end

	def update
		@list = List.find_by(id: params[:id])
		@list.update(
		name: params[:item_name],
        description: params[:item_description],
        stores: params[:where_to_find]
        )
        redirect_to "/lists/index"
	end

	def destroy
		list = List.find_by(id: params[:id])
		list.destroy
		redirect_to "/lists/index"
	end

	def destroy_list
		list = Listname.find_by(id: params[:id])
		Listname.deleteitems(list.listitems)
		list.destroy
		redirect_to "/lists/index"
	end

	def search
		@people = User.search(params[:search],current_user.id,current_user.permissions)
	end

	def perm_mod
		if params[:permissions]
			User.perm_mod(params[:permissions],current_user.id)
			User.mylists_mod(params[:permissions],params[:name])
		end
		redirect_to "/lists/index"
	end

	def show
		@list = Listname.find_by(name: params[:id])
		@list = List.getlist(@list.listitems)
	end

	def listshow
		@listname = Listname.find_by(name: params[:id])
		@list = List.currentlist(@listname.id)
	end

	def perm_del
		if params[:permissions]
			User.perm_del(params[:permissions],current_user.id)
			User.mylist_del(params[:permissions],current_user.id)
		end
		redirect_to "/lists/index"
	end

	def buy
		if params[:commit]
			List.buy(params[:items],current_user.id)
			redirect_to "/lists/#{params[:list]}/show"
		else 
			List.return(params[:param1])
			redirect_to "/lists/#{params[:param2]}/show"
		end
	end

end
