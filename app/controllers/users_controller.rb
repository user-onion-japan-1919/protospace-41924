class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @prototypes = @user.prototypes
    @prototype = @prototypes.find(params[:prototype_id]) if params[:prototype_id]  # プロトタイプが指定されていればそのプロトタイプを設定
    @comment = Comment.new  # コメントを投稿するための新規インスタンス
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

 # ユーザーをIDでセットする
 def set_user
  @user = User.find(params[:id])
end

# ユーザーのストロングパラメータ
def user_params
  params.require(:user).permit(:name, :email, :profile, :occupation, :position)  # 必要な属性を追加
end
end