module Api
  module V1
    class OrdersController < AuthenticatedController
      before_action :set_order, only: [:show, :update, :destroy]

      def index
        @orders = @current_user.orders

        render json: @orders.map(&:serialized)
      end

      def show
        render json: serialized_order
      end

      def create
        @order = @current_user.orders.new(order_params)

        if @order.save
          @order.calculate_price!
          render json: serialized_order, status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def update
        if @order.update(order_params)
          @order.calculate_price!
          render json: serialized_order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @order.destroy

        render json: 'Deleted Successfully', status: :ok
      end

      private

      def set_order
        @order = Order.find(params[:id])
      end

      def serialized_order
        @order.serialized
      end

      def order_params
        params.require(:order).permit(:shipping_address, order_items_attributes: [:id, :product_id, :quantity, :_destroy])
      end
    end
  end
end
