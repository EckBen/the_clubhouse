class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = params[:post_id]

    @comment.save

    redirect_to post_path(@comment.post)
  end

  def comment_params
    params.require(:comment).permit(:comment_body)
  end
end
