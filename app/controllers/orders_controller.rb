
class OrdersController < ApplicationController

  def index
    @orders = Order.order(:status)
  end

  def show
    @order = Order.find(params[:id])
    invites = @order.invites
    invited_ids = []

    invites.each do |invite|
        invited_ids.push(invite.user_id)
    end
    @invited_users=User.find(invited_ids)
  end

  # GET /orders/new
  def new
    @order = Order.new
    @friends = current_user.friends.order(:name)
  end

  # GET /orders/1/edit
  def edit
  end


  def create
    uploaded_file = params[:order][:menu]
    @order = Order.new
    fill_order_data(@order, params)

    if @order.save
        friends=User.find(JSON.parse params[:invitations])


#####  here I'm expecting to get all the users in the group  #####
        group = Group.where(name: params[:order][:group]).first
        group_users = group.users  # this line needs to be replace with a working one
        friends += group_users

        friends.uniq.each do |friend|
            Invite.create(user:friend,order:@order)
        end

        File.open(Rails.root.join('public', 'images', 'menus', uploaded_file.original_filename), 'wb') do |file|
            file.write(uploaded_file.read)
        end
        redirect_to :orders
    else
    render :new
    end
  end


  def update
  end

  def finish
    @order = Order.find(params[:id])
    @order.status=1
    @order.save
    redirect_to :orders
  end


  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to :orders
  end

  def fill_order_data(order, params)
    @order.meal = params[:meal]
    @order.restaurant = params[:order][:restaurant]
    @order.menu = params[:order][:menu].original_filename
    @order.status = 0
    @order.user_id = current_user.id
  end

end
