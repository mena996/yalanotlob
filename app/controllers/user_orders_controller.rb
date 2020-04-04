class UserOrdersController < ApplicationController

  def index
    
    @orderDetails = UserOrder.where(order_id:1);

  end

  def new 
  
  end 

  def create
    @details = UserOrder.create(user_order_params)
          if  @details.save
          else
          redirect to :index
          end
  end

  def destroy
  end


  private
  def user_order_params
    params.permit(:user_id, :order_id, :item_name, :amount, :price, :comment)
  end

end
