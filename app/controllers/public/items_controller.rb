class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :end_user_id)
  end
end
