class HomeController < ApplicationController
  before_action :authenticate_user!
  def index

  	if current_user
		@orders = Order.all.where(user_id: current_user.id).order(created_at: :desc) 
	    @all = []
		current_user.friends.each { |fr|
			@all.push fr.orders
		}
	
		puts "All"
		puts @all.inspect
	    @allmyFriends = User.find(current_user.id).friends 
	

	else
    	redirect_to '/users/sign_in'
    end
  end
end
