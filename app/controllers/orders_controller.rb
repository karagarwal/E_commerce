class OrdersController < ApplicationController
	def index
    @orders = Order.all
    respond_to do |format|
      format.json { render json: {orders: @orders}, status: :ok }
      format.html { @orders = @orders}  
    end
  end

  def new
    @order = Order.new
    respond_to do |format|
      format.json { render json: {order: @order}, status: :ok }
      format.html { }
    end
  end

  def show
    begin
      @order = Order.find(params[:id])
      respond_to do |format|
        format.json { render json: {order: @order}, status: :ok }
        format.html { @order = Order.find(params[:id])}
      end
    rescue ActiveRecord::RecordNotFound => e
      respond_to do |format|
        format.json { render json: {error: e.message}, status: :not_found}
        format.html { render html: {error: e.message}, status: :not_found }
      end
    end
  end

  def create
    begin
      @order = Order.new(order_params)
      respond_to do |format|
        if @order.save
          format.json { render json: { order: @order}, status: :ok }
          format.html { redirect_to request.referrer }
        else
          format.json { render json: @order.errors, status: :unprocessable_entity }
          format.html { render 'new' }
        end
      end
    rescue ActiveRecord::InvalidForeignKey => e
      respond_to do |format|
        format.json { render json: {error: e.message}, status: :unprocessable_entity}
        format.html { render html: {error: e.message}, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    begin
      @order = Order.find(params[:id])
      respond_to do |format|
        @order.destroy
        format.json { render json: { message: "Deleted" }, status: :ok }
        format.html { redirect_to request.referrer }
      end  
    rescue ActiveRecord::RecordNotFound => e
      respond_to do |format|
        format.json { render json: {error: e.message}, status: :not_found }
        format.html { render html: {error: e.message}, status: :not_found }
      end
    end
  end

  def edit
    begin
      @order =  Order.find(params[:id])
      respond_to do |format|
        format.html { @order = Order.find(params[:id]) }
        format.json { render json: {order: @order}, status: :ok }
      end
    rescue ActiveRecord::RecordNotFound => e
      respond_to do |format|
        format.json { render json: {error: e.message}, status: :not_found }
        format.html { render html: {error: e.message}, status: :not_found }
      end
    end
  end

  def update
    begin
      @order = Order.find(params[:id])
      respond_to do |format|
        if @order.update(order_params)
          format.json { render json: {order: @order}, status: :ok }
          format.html { redirect_to @order }
        else
          format.json { render json: @order.errors, status: :unprocessable_entity }
          format.html { render html: {error: e.message}, status: :unprocessable_entity }
        end
      end
    rescue => e
      respond_to do |format|
        format.json { render json: {error: e.message}, status: :unprocessable_entity }
        format.html { render html: {error: e.message}, status: :unprocessable_entity }
      end
    end
  end

  private
  def order_params
    params.require(:order).permit(:order_number, :payment_mode, :item_id, :user_id)
  end
end