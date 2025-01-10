class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype), notice: 'コメントを投稿しました。'
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments.includes(:user)
      flash.now[:alert] = 'コメントの投稿に失敗しました。'
      render 'prototypes/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end