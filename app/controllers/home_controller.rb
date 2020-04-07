class HomeController < ApplicationController
  def index
  end

  def addFriend 
    @friend = User.find(current_user.id).friends
  end 
  
  def addGroup
    @friend = User.find(current_user.id).friends
  end 
  
end