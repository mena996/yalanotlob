class HomeController < ApplicationController
  def index
  end

  def addFriend
    @newfriend = User.new
    @friend = User.find(current_user.id).friends
  end 

  def addNewGroup
    @group = Group.new()
    @group.name = params[:group][:name]
    @group.admin_id = current_user.id 
    respond_to do |format|
      if @group.save
        format.html { redirect_to "/add_group", notice: 'the group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def addNewGroupUser
    p "heyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
    p params[:id]
    p params[:user][:email]
    if Group.find(params[:id]).users << User.where("email=\""+params[:user][:email]+"\"")
      redirect_to group_path(params[:id])
    else
      format.html { render :add_friend }
      format.json { render json: @group.errors, status: :unprocessable_entity }
    end
  end
  
  def addGroup 
    @friend = {}
    @newgroupuser= User.new
    @newgroup = Group.new
    if params[:id]
    @friend = Group.find(params[:id]).users
    end
    @group=User.find(current_user.id).owned_groups
  end 
  
  def addNewFriend
    if User.find(current_user.id).friends << User.where("email=\""+params[:user][:email]+"\"")
      redirect_to :add_friend
    else
      format.html { render :add_friend }
      format.json { render json: @newfriend.errors, status: :unprocessable_entity }
    end
  end

  def destroyGroup
  @group = Group.find(params[:id]).destroy
  respond_to do |format|
    format.html { redirect_to "/add_group" }
    format.json { head :no_content }
  end

  end

  def destroyGroupUser
    p "deleteeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    p params[:gid]
    p params[:uid]
    end
end
 