class CategoriesController < ApplicationController
	def index
    @categories = Category.all
    respond_to do |format|
      format.json { render json: {categories: @categories}, status: :ok }
      format.html { @categories = @categories }       
    end
  end

  def new
    @category = Category.new
    respond_to do |format|
      format.json { render json: {category: @category}, status: :ok }
      format.html { }
    end
  end

  def show
    begin
      @category = Category.find(params[:id])
      respond_to do |format|
        format.json { render json: {category: @category}, status: :ok }
        format.html { @category = Category.find(params[:id])}
      end
    rescue ActiveRecord::RecordNotFound => e
      respond_to do |format|
        format.json { render json: {error: e.message}, status: :not_found}
        format.html { render html: {error: e.message}, status: :not_found }
      end
    end
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.json { render json: { category: @category}, status: :ok }
        format.html { redirect_to @category  }
      else
        format.json { render json: @category.errors, status: :unprocessable_entity }
        format.html { render 'new' }
      end
    end
  end

  def destroy
    begin
      @category = Category.find(params[:id])
      respond_to do |format|
        @category.destroy
        format.json { render json: { message: "Deleted" }, status: :ok }
        format.html { redirect_to request.referrer  }
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
      @category =  Category.find(params[:id])
      respond_to do |format|
        format.html { @category = Category.find(params[:id]) }
        format.json { render json: {category: @category}, status: :ok }
      end
    rescue ActiveRecord::RecordNotFound => e
      respond_to do |format|
        format.json { render json: {error: e.message}, status: :not_found }
        format.html { render html: {error: e.message}, status: :not_found }
      end
    end
  end

  def update
    @category = Category.find(params[:id])
    respond_to do |format|
      if @category.update(category_params)
        format.json { render json: {category: @category}, status: :ok }
        format.html { redirect_to @request.referrer}
      else
        format.json { render json: @category.errors, status: :unprocessable_entity }
        format.html { render html: {error: e.message}, status: :unprocessable_entity }
      end
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end	
end