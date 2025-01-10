class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content, null: false # コメント内容を保存するカラム
      t.references :user, null: false, foreign_key: true # コメントを投稿したユーザーへの外部キー
      t.references :prototype, null: false, foreign_key: true # コメントが紐づくプロトタイプへの外部キー
      t.timestamps
    end
  end
end
