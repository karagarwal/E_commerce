class ItemsController < ApplicationController
	def index
    @items = Item.all
    respond_to do |format|
      format.json { render json: {items: @items}, status: :ok }
      format.html { @items = @items}  
    end
  end

  def new
    @item = Item.new
    respond_to do |format|
      format.json { render json: {item: @item}, status: :ok }
      format.html { }
    end
  end

  def show
    begin
      @item = Item.find(params[:id])
      respond_to do |format|
        format.json { render json: {item: @item}, status: :ok }
        format.html { @item = Item.find(params[:id])}
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
      @item = Item.new(item_params)
      respond_to do |format|
        if @item.save
          format.json { render json: { item: @item}, status: :ok }
          format.html { redirect_to request.referrer }
        else
          format.json { render json: @item.errors, status: :unprocessable_entity }
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
      @item = Item.find(params[:id])
      respond_to do |format|
        @item.destroy
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
      @item =  Item.find(params[:id])
      respond_to do |format|
        format.html { @item = Item.find(params[:id]) }
        format.json { render json: {item: @item}, status: :ok }
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
      @item = Item.find(params[:id])
      respond_to do |format|
        if @item.update(item_params)
          format.json { render json: {item: @item}, status: :ok }
          format.html { redirect_to @item }
        else
          format.json { render json: @item.errors, status: :unprocessable_entity }
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
  def item_params
    params.require(:item).permit(:name, :price, :weight, :brand, :category_id)
  end
end