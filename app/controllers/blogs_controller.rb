class BlogsController < ApplicationController
  before_action :require_login
  before_action :user_logged_in?, only: [:new, :edit, :show, :index]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  
  def index
    @blogs = Blog.all
    @blog = Blog.new
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
    @blogs = Blog.all
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    @comment = @blog.comments.build
    @comments = @blog.comments
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
    @blog.user_id = current_user.id
    render :new if @blog.invalid?
  end
  
  def require_login
    unless logged_in?
      flash[:error] = "Please Login"
      redirect_to new_session_path
    end
  end
  
  def comment
    @blog = Blog.find(params[:id])
    @comment = Comment.new(comment_params.merge(post_id: @blog.id))
    @comment.save!
    redirect_to action: :show
  rescue
    render action: :show
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content,:user_id)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
  
  def comment_params
    params.require(:comment).permit(:content)
  end

end