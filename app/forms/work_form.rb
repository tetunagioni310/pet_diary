class WorkForm
  # 通常のモデルのようにvalidationなどを使えるようにする
  include ActiveModel::Model
  # ActiveRecordのカラムのような属性を加えられるようにする
  include ActiveModel::Attributes

  # Formで一時的に選択したペットのID
  attr_accessor :pet_ids

  attribute :pet_id, :integer
  attribute :work_name, :string
  attribute :customer_id, :integer

  with_options presence: true do
    validates :pet_id
    validates :work_name
    validates :customer_id
  end

  # ペットの名前に♂ならくん、♀ならちゃんをつける
  def pet_names
    Pet.where(id: pet_ids).map do |pet|
      "#{pet.pet_name}#{pet.pet_gender}"
    end
  end

  def save!
    Work.create!(customer_id: customer_id, pet_id: pet_id, work_name: work_name)
  end
end