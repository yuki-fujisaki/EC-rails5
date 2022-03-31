class Public::OrdersController < ApplicationController
  before_action :ensure_cart_items, only: [:new,:create,:update]
  def index
  end

  def new
    @order = Order.new
  end

  def create
    order = current_end_user.orders.build(order_params)
    order.save
    @shipping_cost = order.shipping_cost
    current_end_user.cart_items.each do |cart_item|
    order_detail = order.order_details.build
    order_detail.item_id = cart_item.item_id
    order_detail.tax_included_price = cart_item.item.tax_excluded_price*1.1
    order_detail.quantity = cart_item.amount
    order_detail.save
    end
    current_end_user.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def show
  end

  def confirm
    @order = current_end_user.orders.new
    @order.payment_method = params[:order][:payment_method]

    @shipping_cost = @order.shipping_cost
    @cart_items = CartItem.all
    @cart = @cart_items.where(end_user_id: current_end_user.id)
      @sum = 0#初期値
      @cart_items.each do |cart_item|
        if current_end_user.id == cart_item.end_user_id
        cart_item.item.tax_excluded_price
        @sum += cart_item.item.tax_excluded_price * cart_item.amount
        end
    end

    @order.billing_amount = @sum*1.1 + @shipping_cost

    if  params[:order][:address_option] == "0"

      @order.postal_code = current_end_user.postal_code
      @order.name = current_end_user.last_name + current_end_user.first_name
      @order.address = current_end_user.address

    elsif params[:order][:address_option] == "1"

      @order.postal_code = Address.find_by(address: params[:order][:registered_address]).postal_code
      @order.name = Address.find_by(address: params[:order][:registered_address]).name
      @order.address = params[:order][:registered_address]

    elsif params[:order][:address_option] == "2"
      # session[:postal_code] = params[:order][:postal_code]
      # session[:name] = params[:order][:name]
      # session[:address] = params[:order][:address]

      @order.postal_code = params[:order][:postal_code]
      @order.name = params[:order][:name]
      @order.address = params[:order][:address]
    end
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :name, :address, :payment_method, :shipping_cost, :end_user_id, :sales_order_status, :billing_amount)
  end

  def ensure_cart_items
    @cart_item = CartItem.find_by(end_user_id: current_end_user.id)
    unless @cart_item.present?
      redirect_back(fallback_location: root_path)
    end
  end

end
