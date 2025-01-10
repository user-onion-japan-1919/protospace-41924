class Prototype < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy   # commentsテーブルとのアソシエーション

  validates :title, :catch_copy, :concept, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true

  def was_attached?
    self.image.attached?
  end

end
