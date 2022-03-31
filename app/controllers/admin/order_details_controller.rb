class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])

    if params[:order_detail][:production_status] == "under_production"
      @order_detail.update(production_status: "under_production")
    end

    @order = @order_detail.order

    var = 0
    @order.order_details.each do |o|
      if o.production_status == "under_production"
        var += 1
      end
    end

    if var >= 1
      @order.update(sales_order_status: "in_production")
      var = 0
    end

    @order_detail.update(production_status: params[:order_detail][:production_status])

    if @order.order_details.where(production_status: "production_completed").count == @order.order_details.count
      @order.update(sales_order_status: "preparing_to_ship")
    end

    redirect_to admin_order_path(@order_detail.order)
  end
end
