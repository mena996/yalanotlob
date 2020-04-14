class HomeController < ApplicationController
  before_action :addFriend, only: [:addNewFriend]

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
      redirect_to "/users/sign_in"
    end
  end

  def addFriend
    @newfriend = User.new
    @friend = User.find(current_user.id).friends
  end

  def removeFriend
    if User.find(current_user.id).friends.delete(User.find(params[:id]))
      redirect_to add_friend_path
    else
      format.html { render :add_friend }
      format.json { render json: @newfriend.errors, status: :unprocessable_entity }
    end
  end

  def addNewGroup
    @newgroup = Group.new()
    @newgroup.name = params[:group][:name]
    @newgroup.admin_id = current_user.id
    respond_to do |format|
      if @newgroup.save
        format.html { redirect_to "/add_group", notice: "the group was successfully created." }
        format.json { render :show, status: :created, location: @newgroup }
      else
        @friend = {}
        @newgroupuser = User.new
        # @newgroup = Group.new
        @group = User.find(current_user.id).owned_groups
        format.html { render :addGroup }
        format.json { render json: @newgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  def addNewGroupUser
    if User.find(current_user.id).friends.where("email=\"" + params[:user][:email] + "\"").exists?
      if !Group.find(params[:id]).users.where("email=\"" + params[:user][:email] + "\"").exists?
        if Group.find(params[:id]).users << User.find(current_user.id).friends.where("email=\"" + params[:user][:email] + "\"")
          redirect_to group_path(params[:id])
        else
          # render :add_friend
          # render json: @group.errors, status: :unprocessable_entity
          format.html { redirect_to "/add_group", notice: @group.errors }
        end
      else
        respond_to do |format|
          format.html { redirect_to "/add_group/" + params[:id], notice: "user already in the group" }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to "/add_group/" + params[:id], notice: "user does not exist" }
      end
    end
  end

  def addGroup
    @friend = {}
    @newgroupuser = User.new
    @newgroup = Group.new
    if params[:id]
      @friend = Group.find(params[:id]).users
    end
    @group = User.find(current_user.id).owned_groups
  end

  def addNewFriend
    @newFriend = User.where("email=\"" + params[:user][:email] + "\"").first
    user = User.find(current_user.id)
    if @newFriend == nil
      @errors = "user doesnot exist"
      render :addFriend
    elsif @newFriend[:id] == current_user.id
      @errors = "you canot add your self"
      render :addFriend
    else
      if user.friends.include? @newFriend
        @errors = "you are aleary friends"
        render :addFriend
      else
        user.friends << @newFriend
        redirect_to :add_friend
      end
    end
  end

  def destroyGroup
    @group = Group.find(params[:id]).destroy
    # redirect_to :add_group
    respond_to do |format|
      format.html { redirect_to "/add_group", notice: "the group was successfully deleted." }
    end
  end

  def destroyGroupUser
    if Group.find(params[:gid]).users.delete(User.find(params[:uid]))
      # redirect_to group_path(params[:gid])
      respond_to do |format|
        format.html { redirect_to group_path(params[:gid]), notice: "the user was successfully deleted." }
      end
    else
      respond_to do |format|
        format.html { render :add_friend }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end
end
