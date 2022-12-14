class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pets, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments
  has_many :items, dependent: :destroy
  has_many :use_items, dependent: :destroy
  has_many :works, dependent: :destroy
  has_many :favorite_items, dependent: :destroy
  has_many :schedules, dependent: :destroy


  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_one_attached :customer_image

  validates :email, presence: true
  validates :nick_name, presence: true, length: { maximum: 10}
  validates :introduction, presence: true

  enum status: { nonreleased: 0, released: 1}

  def get_customer_image(width, height)
    unless customer_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      customer_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    customer_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
      customer.nick_name = "ゲスト"
    end
  end

  # ユーザーがいいねしたかを判別する
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  # フォローしたときの処理
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end
  # フォローを外すときの処理
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end
  # フォローしているか判定
  def following?(customer)
    followings.include?(customer)
  end

  # 会員が退会しているかどうか
  def is_deleted?
    if self.is_deleted == false
      "有効"
    else
      "退会"
    end
  end

  def self.customer_search(keyword)
    where("nick_name LIKE ? ", "#{keyword}")
  end
end
