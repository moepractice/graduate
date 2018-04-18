class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :destroy, :update,:show]
  
  def index
    @comments = Comment.all
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    respond_to do |format|
      if @comment.save
         redirect_to blog_path(@blog)
      else
        render  'new' 
      end
    end
  end
  
  def new
    if params[:back]
      @comment = Comment.new(blog_params)
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