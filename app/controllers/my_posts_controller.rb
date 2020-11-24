class MyPostsController < ApplicationController
  def index
    if !current_user.nil?
      @posts = Post.where(user_id: current_user.id)
    else
      redirect_to new_user_session_path
    end
  end
end
