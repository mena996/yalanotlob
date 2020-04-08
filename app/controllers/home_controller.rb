class HomeController < ApplicationController
  def index
  end

  def addFriend
    @newfriend = User.new
    @friend = User.find(current_user.id).friends
  end 
  
  def addGroup 
    @friend = {}
    if params[:id]
    @friend = Group.find(params[:id]).users
    end
    @group=User.find(current_user.id).owned_groups
  end 
  
  def addNewFriend
    @user=User.find(current_user.id).friends << User.where("email=\""+params[:user][:email]+"\"")
    if @user
      redirect_to :add_friend
    end
  end

  def destroyGroup
  p "heloooooooooooooooooooooooooooooo"
  end
end
 