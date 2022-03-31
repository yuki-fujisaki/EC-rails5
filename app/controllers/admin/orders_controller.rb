class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    # ①注文ステータスが 入金確認 → 全ての製作ステータスを 製作待ち
    if @order.sales_order_status == "confirmation_of_payment"
      # @order.order_details.each do |order_detail|
      @order.order_details.update(production_status: 1)
    end
    # ②製作ステータスが一つでも 製作中 → 注文ステータスを 製作中
      #params[:production_status] が”製作中”
    # ③製作ステータスが全て 製作完了 → 注文ステータスを 発送準備中
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :name, :address, :payment_method, :shipping_cost, :end_user_id, :sales_order_status, :billing_amount)
  end
end
