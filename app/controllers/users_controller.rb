class UsersController < ApplicationController
	def index
		@users = User.all
		respond_to do |format|
			format.json { render json: {users: @users}, status: :ok }
			format.html { @users = @users }  
		end
	end

	def show
		begin
			@user = User.find(params[:id])
			respond_to do |format|
				format.json { render json: {user: @user}, status: :ok }
				format.html { @user = User.find(params[:id])}
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error: e.message}, status: :not_found}
				format.html { render html: {error: e.message}, status: :not_found }
			end
		end
	end

  def new
    @user = User.new
    respond_to do |format|
      format.json { render json: {user: @user}, status: :ok }
      format.html { }
    end
  end

	def edit
		begin
			@user = User.find(params[:id])
			respond_to do |format|
				format.html { @user = User.find(params[:id]) }
				format.json { render json: {user: @user}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error: e.message}, status: :not_found }
				format.html { render html: {error: e.message}, status: :not_found }
			end
		end
	end

  def create
		@user = User.create(user_params)
		if @user.save
			respond_to do |format|
				format.json { render json: { user: @user }, status: :ok }
				format.html { redirect_to system_path(@system) }
			end
		else
			respond_to do |format| 
				format.json { render json: {message: @user.errors}, status: :unprocessable_entity }
				format.html { render html: {message: @user.errors}, status: :unprocessable_entity}
			end
		end
	end

	def destroy
		begin
			@user = User.find(params[:id])
			respond_to do |format|
				@user.destroy
				format.json { render json: { message: "Deleted" }, status: :ok }
				format.html { redirect_to  request.referrer}
			end  
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error: e.message}, status: :not_found }
				format.html { render html: {error: e.message}, status: :not_found }
			end
		end
	end

	def update
		@user = User.find(params[:id])
		respond_to do |format|
			if @user.update(user_params)
				format.json { render json: {user: @user}, status: :ok }
				format.html { redirect_to @user }
			else
				format.json { render json: @user.errors, status: :unprocessable_entity }
				format.html { render html: {error: e.message}, status: :unprocessable_entity }
			end
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :address, :phone, :gender, :username, :password)
	end
end