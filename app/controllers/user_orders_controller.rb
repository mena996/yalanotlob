class UserOrdersController < ApplicationController


    $errors = []
    def index
    end

    def new 
    end 

    def create
      @user_order = UserOrder.create(user_order_params)
      $errors =@user_order.errors.full_messages 
      redirect_to user_order_path(id: params[:order_id]) 

    end

    def show
      @order = Order.find(params[:id])
      @invited = Invite.where(order_id: params[:id])
      @joined = Invite.where(order_id: params[:id]).where(invitation_status: 1)
      @orderDetails = UserOrder.where(order_id: params[:id]);


    end

    def destroy
      @user_order = UserOrder.find(params[:id])
      @id = @user_order.order_id
      @user_order.destroy
      redirect_to user_order_path(id: @id) 

    end

  
    private
    def user_order_params
      params.permit(:user_id, :order_id, :item_name, :amount, :price, :comment)
    end

end
