class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save!
      redirect_to post_path(@comment.post), notice: "Comment was successfully created."
    else
      redirect_to post_path(@comment.post), alert: "Comment was not created."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.user != current_user
      return redirect_to post_path(@comment.post), alert: "You can only delete your own comments."
    end
    
    if @comment.destroy!
      redirect_to post_path(@comment.post), notice: "Comment was successfully deleted."
    else
      redirect_to post_path(@comment.post), alert: "Comment was not deleted."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end

end