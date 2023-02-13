# frozen_string_literal: true

class Pet < ApplicationRecord
  belongs_to :customer
  belongs_to :group
  has_many :posts, dependent: :destroy
  has_many :works, dependent: :destroy

  validates :pet_name, presence: true, length: { maximum: 8 }
  validates :group_id, presence: true
  validates :gender, presence: true
  validates :birthday, presence: true

  has_one_attached :pet_image

  enum gender: { ♂: 1, ♀: 2 }

  def get_pet_image(width, height)
    # ペットに画像が添付されていない時
    unless pet_image.attached?
      file_path = Rails.root.join("app/assets/images/default-image.jpg")
      pet_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    pet_image.variant(resize_to_limit: [width, height]).processed
  end

  # ペットの性別がオスの場合は'くん'、それ以外は'ちゃん'
  def pet_gender
    gender == "♂" ? "くん" : "ちゃん"
  end

  # 誕生日から年齢を計算するメソッド
  def age(date)
    date_format = "%Y%m%d"
    (date.strftime(date_format).to_i - birthday.strftime(date_format).to_i) / 10_000
  end
end
