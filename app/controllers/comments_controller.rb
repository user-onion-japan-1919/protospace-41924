class CommentsController < ApplicationController
  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = Comment.new(comment_params)
    if @comment.content.blank? # コメントが空の場合
      redirect_to prototype_path(@prototype) # 空のコメントが送信された場合は詳細ページに戻す
    elsif @comment.save
      redirect_to prototype_path(@prototype), notice: 'コメントが投稿されました。'
    else
      # コメントが保存できない場合（内容が空でない場合）
      render 'prototypes/show', status: :unprocessable_entity
    end
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:prototype_id])  # prototype_idがparamsに含まれていることを確認
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end