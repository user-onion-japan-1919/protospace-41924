class Comment < ApplicationRecord
  belongs_to :prototype  # tweetsテーブルとのアソシエーション
  belongs_to :user  # usersテーブルとのアソシエーション

# バリデーション
validates :content, presence: true

end
 
