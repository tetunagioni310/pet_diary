class Post < ApplicationRecord

  belongs_to :pet
  belongs_to :customer
  has_many :likes, dependent: :destroy
  has_many :liked_customers, through: :likes, source: :customer
  has_many :comments, dependent: :destroy


  has_one_attached :post_image

  validates :pet_id, presence: true
  validates :customer_id, presence: true
  validates :post_title, presence: true
  validates :post_content, presence: true

  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search(keyword, current_customer)
    Post.joins(:pet).where("pet_name LIKE ? ", "%#{keyword}%").where(customer_id: current_customer.id)
  end
end
