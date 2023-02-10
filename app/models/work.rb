class Work < ApplicationRecord
  belongs_to :customer
  belongs_to :pet
  has_many :work_details, dependent: :destroy

  validates :customer_id, presence: true
  validates :pet_id, presence: true
  validates :work_name, presence: true
  
  # ログイン中の会員のワークを作業名とペット名で検索する
  def self.pet_work_search(keyword, _current_customer)
    Work.joins(:pet).where('work_name LIKE ? OR pet_name LIKE ?', "%#{keyword}%", "%#{keyword}%")
  end
end
