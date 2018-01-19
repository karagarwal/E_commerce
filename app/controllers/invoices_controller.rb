class InvoicesController < ApplicationController
	def index
    @invoices = Invoice.all
    respond_to do |format|
      format.json { render json: {invoices: @invoices}, status: :ok }
      format.html { @invoices = @invoices }   
    end
  end

  def new
    @invoice = Invoice.new
    respond_to do |format|
      format.json { render json: {invoice: @invoice}, status: :ok }
      format.html { }
    end
  end

  def show
    begin
      @invoice = Invoice.find(params[:id])
      respond_to do |format|
        format.json { render json: {invoice: @invoice}, status: :ok }
        format.html { @invoice = Invoice.find(params[:id])}
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
      @invoice = Invoice.new(invoice_params)
      respond_to do |format|
        if @invoice.save
          format.json { render json: { invoice: @invoice}, status: :ok }
          format.html { redirect_to request.referrer }
        else
          format.json { render json: @invoice.errors, status: :unprocessable_entity }
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
      @invoice = Invoice.find(params[:id])
      respond_to do |format|
        @invoice.destroy
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
      @invoice =  Invoice.find(params[:id])
      respond_to do |format|
        format.html { @invoice = Invoice.find(params[:id]) }
        format.json { render json: {invoice: @invoice}, status: :ok }
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
      @invoice = Invoice.find(params[:id])
      respond_to do |format|
        if @invoice.update(invoice_params)
          format.json { render json: {invoice: @invoice}, status: :ok }
          format.html { redirect_to @ainvoice }
        else
          format.json { render json: @invoice.errors, status: :unprocessable_entity }
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
  def invoice_params
    params.require(:invoice).permit(:invoice_number, :amount, :order_id)
  end
end