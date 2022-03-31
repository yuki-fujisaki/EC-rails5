class Admin::ItemsController < ApplicationController
  def index
    # @items = Item.all
    # Item.rbに上記を記述
    @items = Item.search(params[:search])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: "You have created book successfully."
    else
      @items = Item.all
      render 'new'
    end
  end

  def search
    @items = Item.search(params[:search])
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :tax_excluded_price, :is_active, :image, :genre_id)
  end
end
