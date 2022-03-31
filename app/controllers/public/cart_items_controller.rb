class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.end_user_id = current_end_user.id
    if current_end_user.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
       cart_item = current_end_user.cart_items.find_by(item_id: params[:cart_item][:item_id])
       cart_item.amount += params[:cart_item][:amount].to_i
       cart_item.save
       redirect_to cart_items_path, notice: "You have created book successfully."
    elsif @cart_item.save
      redirect_to cart_items_path, notice: "You have created book successfully."
    else
      redirect_to item_path(@cart_item)
    end
  end

  def update
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item.update(amount: params[:cart_item][:amount])
      redirect_to cart_items_path, notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_item = current_end_user.cart_items
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
end
