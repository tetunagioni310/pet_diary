# frozen_string_literal: true

require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "投稿にコメントをする" do
    before do
      @comment = create(:comment)
    end

    it "comment_contentが存在すれば登録できること" do
      expect(@comment).to be_valid  # comment.valid? が true になればパスする
    end

    it "コメントが空欄の場合、コメント作成失敗する" do
      @comment.comment_content = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("コメントを入力してください")
    end
  end
end
