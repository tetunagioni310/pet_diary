# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, type: :model do
  describe "投稿登録" do
    before do
      @post = create(:post)
    end

    it "post_title、post_content、post_imageが存在すれば登録できる" do
      expect(@post).to be_valid  # item.valid? が true になればパスする
    end

    it "post_titleが空欄の場合、登録できない" do
      @post.post_title = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("投稿名を入力してください")
    end

    it "post_contentが空欄の場合、登録できない" do
      @post.post_content = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("内容を入力してください")
    end

    it "post_imageが空欄の場合、登録できない" do
      @post.post_image = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("画像を入力してください")
    end
  end
end
