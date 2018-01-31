class ListsController < ApplicationController
	def home
		if current_user
			redirect_to "/lists/index"
		end
	end

	def index
		@list = List.where(userid: current_user.id)
		@permissions = User.fill(current_user.permissions)
		@mylists =  User.wishlists(current_user.mylists)
	end

	def new
		
	end

	def create
		List.create(
        name: params[:item_name],
        description: params[:item_description],
        stores: params[:where_to_find],
        userid: current_user.id
        )
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

	def search
		@people = User.search(params[:search],current_user.id,current_user.permissions)
	end

	def perm_mod
		User.perm_mod(params[:permissions],current_user.id)
		User.mylists_mod(params[:permissions],current_user.id)
		redirect_to "/lists/index"
	end

	def show
		@list = User.find_by(name: params[:id])
		@list = List.getlist(@list.id)
	end

	def perm_del
		User.perm_del(params[:permissions],current_user.id)
		User.mylist_del(params[:permissions],current_user.id)
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
