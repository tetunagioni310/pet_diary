# frozen_string_literal: true

require "rails_helper"

RSpec.describe Work, type: :model do
  describe "ワークを作成する" do
    before do
      @work = create(:work)
    end

    it "有効な情報を登録すればワークを作成できること" do
      expect(@work).to be_valid  # comment.valid? が true になればパスする
    end

    it "work_nameが空欄の場合、登録できない" do
      @work.work_name = nil
      @work.valid?
      expect(@work.errors.full_messages).to include("ワーク名を入力してください")
    end
  end
end
