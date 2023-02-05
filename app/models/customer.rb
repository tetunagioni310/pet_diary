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
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # フォローをした、されたの関係
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_one_attached :customer_image

  validates :email, presence: true
  validates :nick_name, presence: true, length: { maximum: 15 }
  validates :introduction, presence: true

  enum status: { nonreleased: 0, released: 1 }

  # フォロー通知情報作成・保存メソッド
  def create_notification_follow!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow'])
    return unless temp.blank?

    notification = current_user.active_notifications.new(
      visited_id: id,
      action: 'follow'
    )
    notification.save if notification.valid?
  end

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
      customer.nick_name = 'ゲスト'
    end
  end

  # ユーザーがいいねしたかを判別する
  def already_liked?(post)
    likes.exists?(post_id: post.id)
  end

  # フォローしたときの処理
  def follow(customer_id)
    # ログイン中の会員がfollowed_idをフォローする
    relationships.create(followed_id: customer_id)
  end

  # フォローを外すときの処理
  def unfollow(customer_id)
    # ログイン中の会員がfollowed_idの会員をフォロー解除する
    relationships.find_by(followed_id: customer_id).destroy
  end

  # フォローしているか判定
  def following?(customer)
    # customerがfollowingsに含まれているかどうかを確認する
    followings.include?(customer)
  end

  # 会員が退会しているかどうか
  def deleted?
    if is_deleted == false
      '有効'
    else
      '退会'
    end
  end

  def self.customer_search(keyword)
    Customer.where(status: 1).where('nick_name LIKE ? ', keyword.to_s)
  end
end
