class PaymentJob < ApplicationJob # TODO: rename! May be i.e. OrderProcessingJob
  queue_as :default

  def perform(order_id)
    order = Order.find_by(id: order_id)
    return if order.blank? # TODO: Also throw exception here

    Order.transaction do
      order.order_items.includes(:product).each do |item|
        remaining_stock = item.product.stock.to_i - item.quantity
        raise "Low Inventory of Product ID: #{product.id}" if remaining_stock < 0

        item.product.update(stock: remaining_stock)
      end
      order.paid_at = Time.zone.now
      order.paid!
    end

  rescue
    order.cancelled!
  end
end
