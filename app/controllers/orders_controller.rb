class OrdersController < ApplicationController


  def index
    @orders = Order.order(:status)
  end

  def show
    @order = Order.find(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end


  def create
    uploaded_file = params[:order][:menu]
    @order = Order.new
    fill_order_data(@order, params)

    if @order.save
      # assume we have array of friends ids firends=User.find([#ids of users])
      friends=User.find([3,4])

      friends.each do |friend|
        # Notification.create(recipient:friend, actor:current_user, action:"invited you to his", notifiable: @order)
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
