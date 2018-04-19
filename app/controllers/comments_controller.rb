class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :destroy, :update,:show]
  
  def index
    @comments = Comment.all
    @comment = Comment.new
  end
  
  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @blog, notice: "コメントしました"
    else
      redirect_to @blog, notice: "コメント出来ませんでした。"
    end
  end
  
  def new
    if params[:back]
      @comment = Comment.new(comment_params)
    else
      @comment = Comment.new
    end
  end
  
  def edit
    @blog = @comment.blog
  end
 
  def update
    if @comment.update(comment_params)
       redirect_to blog_path(@comment.blog), notice: "コメントを更新しました"
    else
      render 'edit'
    end
  end

  def show
    @blog = @comment.blog
    render 'index'
  end

  def destroy
    @comment.destroy
    render 'index'
  end
  
  private
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end
    
    def set_comment
      @comment=Comment.find(params[:id])
    end
end