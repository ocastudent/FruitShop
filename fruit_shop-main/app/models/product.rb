class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true  # 商品名は必須で一意
  validates :price, presence: true                   # 価格は必須

  has_one_attached :photo

    def thumbnail
      photo.variant(resize_to_limit: [150, 150]).processed  # 画像を 150x150 ピクセル以内にリサイズ
    end
end
