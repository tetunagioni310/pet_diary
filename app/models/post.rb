class Post < ApplicationRecord

  belongs_to :pet
  belongs_to :customer
  belongs_to :group
  has_many :likes, dependent: :destroy
  has_many :liked_customers, through: :likes, source: :customer
  has_many :comments, dependent: :destroy


  has_one_attached :post_image

  validates :pet_id, presence: true
  validates :customer_id, presence: true
  validates :post_title, presence: true
  validates :post_content, presence: true
  validates :post_image, presence: true

  def get_post_image(width, height)
    if post_image
      post_image.variant(resize_to_limit: [width, height]).processed
    end
  end

  def self.my_post_search(keyword, current_customer)
    Post.joins(:pet).where("pet_name LIKE ? ", "%#{keyword}%").where(customer_id: current_customer.id)
  end

  def self.other_post_search(keyword, customer)
    Post.joins(:pet).where("pet_name LIKE ? ", "%#{keyword}%").where(customer_id: customer.id)
  end

  def self.all_post_search(keyword)
    Post.joins(:pet).joins(:group).where("post_title LIKE ? OR post_content LIKE ? OR pet_name LIKE ? OR pet_type LIKE ? OR group_name LIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
  end
end
