class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params.except(:product_ids, :quantities))
    selected_products = Product.where(id: params[:order][:product_ids])

    product_quantities = params[:order][:quantities].to_enum.to_h.map { |key, value| [key.to_i, value.to_i] }.to_enum.to_h

    total_price = 0
    selected_products.each do |product|
      quantity = product_quantities[product.id] || 1 # Default quantity to 1 if not provided
      total_price += product.price * quantity
    end
    @order.total = total_price

    if @order.save

      selected_products.each do |product|
        quantity = product_quantities[product.id] || 1
        OrderProduct.create(order: @order, product: product, quantity: quantity)
      end
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_path, status: :see_other, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end


    def order_params
      params.require(:order).permit(:client_id, product_ids: [], quantities: [:id, :quantity])
      params.require(:order).permit(:client_id, :status, :placed_at)
      params.require(:order).permit(:client_id, :total, :status, :placed_at)
    end
end
