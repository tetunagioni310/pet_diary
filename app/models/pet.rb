class Pet < ApplicationRecord
  belongs_to :customer
  belongs_to :group
  has_many :posts, dependent: :destroy
  has_many :works, dependent: :destroy

  validates :pet_name, presence: true
  validates :pet_introduction, presence: true
  validates :pet_type, presence: true
  validates :gender, presence: true
  validates :age, presence: true
  validates :birthday, presence: true

  has_one_attached :pet_image

  enum gender: { ♂: 1, ♀: 2 }

  def get_pet_image(width, height)
    unless pet_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      pet_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
  pet_image.variant(resize_to_limit: [width, height]).processed
  end

  def pet_gender
    gender == "♂" ? "くん" : "ちゃん"
  end
end