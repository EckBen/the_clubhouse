class CommentsController < ApplicationController
  before_action :find_commentable
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id

    @comment.save

    redirect_to post_path(@id)
  end

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
