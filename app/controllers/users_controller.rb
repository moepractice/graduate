class UsersController < ApplicationController
  def new
     @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    @favorites = @user.favorites
    @comments = @user.comments.find_by(blog_id: params[:blog_id])
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end