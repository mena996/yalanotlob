class UserOrdersController < ApplicationController

  def index
    @orderDetails = UserOrder.where(order_id:1);

  end

  def new 
    @user_orders = UserOrder.new
  end 

  def create
    @user_order = UserOrder.create(user_order_params)
          if @user_order.save           
          else
          end
          # redirect_to action: :index

  end

  def show
    @order = Order.find(params[:id])
    @orderDetails = UserOrder.where(order_id: params[:id]);

  end

  def destroy
    @user_order = UserOrder.find(params[:id])
    @user_order.destroy
    redirect_to action: :index

  end

  


  private
  def user_order_params
    params.permit(:user_id, :order_id, :item_name, :amount, :price, :comment)
  end

end
