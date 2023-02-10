class Post < ApplicationRecord
  belongs_to :pet
  belongs_to :customer
  has_many :likes, dependent: :destroy
  has_many :liked_customers, through: :likes, source: :customer
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one :group, through: :pet, source: :group

  has_one_attached :post_image

  validates :pet_id, presence: true
  validates :customer_id, presence: true
  validates :post_title, presence: true
  validates :post_content, presence: true
  validates :post_image, presence: true

  # いいね通知レコード作成・保存メソッド
  def create_notification_like!(current_customer)
    # すでに「いいね」されているか検索
    temp = Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and action = ? ',
                               current_customer.id, customer_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    return unless temp.blank?

    notification = current_customer.active_notifications.new(
      post_id: id,
      visited_id: customer_id,
      action: 'like'
    )
    # 自分の投稿に対する自分のいいねの場合は、通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    # 通知レコードを保存
    notification.save if notification.valid?
  end

  # コメント通知情報作成メソッド
  def create_notification_comment!(current_customer, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:customer_id).where(post_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_customer, comment_id, temp_id['customer_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_customer, comment_id, customer_id) if temp_ids.blank?
  end

  # コメント通知情報保存メソッド
  def save_notification_comment!(current_customer, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_customer.active_notifications.new(
      post_id: id,
      comment_id:,
      visited_id:,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    # 通知情報を保存
    notification.save if notification.valid?
  end

  def get_post_image(width, height)
    # image添付されてされていない場合
    return unless post_image

    post_image.variant(resize_to_limit: [width, height]).processed
  end

  # 公開中の全ての投稿を取得
  def self.released_post
    Post.joins(:customer).where(customers: { status: 1 })
  end
  
  # 公開中のグループ別投稿を取得
  def self.released_post_group(group)
    Post.joins(:customer, :pet).where(customers: { status: 1 }, pets: { group_id: group.id })
  end
  
  # ログイン中の会員の投稿からペット名で検索する
  def self.my_post_search(keyword, current_customer)
    Post.joins(:pet).where('pet_name LIKE ? ', "%#{keyword}%").where(customer_id: current_customer.id)
  end

  # 会員別の投稿をペット名で検索するメソッド
  def self.other_post_search(keyword, customer)
    Post.joins(:pet).where('pet_name LIKE ? ', "%#{keyword}%").where(customer_id: customer.id)
  end
  
  # 公開中の全ての投稿から投稿名、投稿内容、ペット名、ペットの種類から検索
  def self.all_post_search(keyword)
    Post.joins(:pet, :customer).where(customers: { status: 1 }).where(
      'post_title LIKE ? OR post_content LIKE ? OR pet_name LIKE ? OR pet_kind LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"
    )
  end
end
