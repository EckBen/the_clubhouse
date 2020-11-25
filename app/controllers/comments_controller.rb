class CommentsController < ApplicationController
  before_action :find_commentable
  before_action :authenticate_user!
  
  def index
      @comments = Comment.where(user_id: current_user.id)
  end

  def new
    @comment = Comment.new
  end
  
  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id

    @comment.save

    redirect_to post_path(@id)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)

    respond_to do |format|
      format.html { redirect_to my_comments_path, notice: 'Comment updated.' }
      format.json { head :no_content }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    @comment.destroy
    
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_body)
  end

  def find_commentable
    if params[:comment_id]
      @commentable = Comment.find_by_id(params[:comment_id])
      temp_commentable = @commentable

      until temp_commentable.commentable_type == 'Post'
        temp_commentable = Comment.find_by_id(temp_commentable.commentable_id)
      end
      
      @id = Post.find_by_id(temp_commentable.commentable_id)
    elsif params[:post_id]
      @commentable = Post.find_by_id(params[:post_id])
      @id = @commentable.id
    end
  end
end
