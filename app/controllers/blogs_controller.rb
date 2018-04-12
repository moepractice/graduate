class BlogsController < ApplicationController
  before_action :require_login
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  
  def index
    @blogs = Blog.all
    @blog = Blog.new
    @user = current_user
  end
  
  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end
  
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
       redirect_to blogs_path, notice: "投稿完了！今日もお疲れ様です。"
    else
       render 'new'
    end
  end
  
  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    @comments = @blog.comments.includes(:user).all
    @comment  = @blog.comments.build(user_id: current_user.id) if current_user
  end
  
  def edit
  end

  def update
    if @blog.update(blog_params)
       redirect_to blogs_path, notice: "編集しました！"
    else
      render 'edit'
    end 
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end
  
  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end
  
  def require_login
    unless logged_in?
      flash[:error] = "Please Login"
      redirect_to new_session_path
    end
  end
  
  private
  def blog_params
    params.require(:blog).permit(:title, :content,:user_id)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
end