class PrototypesController < ApplicationController
  # ログインしているユーザーのみアクセスを許可
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
    if @prototypes.empty?
      flash[:alert] = "プロトタイプがありません"
    end
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    @prototype.user = current_user
    if @prototype.save
      redirect_to root_path, notice: '投稿が成功しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show

    @prototype = Prototype.find(params[:id])
    @comment = Comment.new  
    @comments = @prototype.comments.includes(:user)  # ここで投稿に関連するコメントを取得
  end

  def edit
    # @prototype はbefore_actionで設定されているので、ここでは何もする必要はありません
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to @prototype, notice: "プロトタイプを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to prototypes_path, notice: "プロトタイプを削除しました。"
  end

  private

  def set_prototype
    # find_byを使って、見つからない場合にリダイレクトさせる
    @prototype = Prototype.find_by(id: params[:id])
    unless @prototype
      redirect_to prototypes_path, alert: "プロトタイプが見つかりませんでした。"
    end
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)  # 必要なパラメータを許可
  end

  # authorize_user! メソッド
  def authorize_user!
    # プロトタイプが存在している前提で、ユーザーが一致しない場合にリダイレクト
    if @prototype.user != current_user
      redirect_to root_path, alert: "あなたはこのプロトタイプを編集できません。"
    end
  end
end