class UserOrdersController < ApplicationController


    $errors = []
    def index
    end

    def new 
    end 

    def create
      @invited = Invite.where(order_id: params[:order_id]).where(user_id: current_user.id).where(invitation_status: 1).exists?
      @orderOwner = Order.where(id: params[:order_id]).where(user_id: current_user.id).exists?
      @status = Order.where(id: params[:order_id]).where(status: 0).exists?
      if @invited == true && @status == true || @orderOwner == true && @status == true
        @user_order = UserOrder.create(user_order_params)
        $errors =@user_order.errors.full_messages       
      else
          if @status == false
            $errors.push("Sorry... this order has been finished!")
          else
            $errors.push("Sorry...NOT JOINED!  you are not allowed to add orders.")
          end
      end
      redirect_to user_order_path(id: params[:order_id]) 

    end

    def show
      @order = Order.find(params[:id])
      @invited = @order.invites.where(order_id: params[:id])
      @joined = @order.invites.where(order_id: params[:id]).where(invitation_status: 1)
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
