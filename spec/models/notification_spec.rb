# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notification, type: :model do
  describe "各種通知" do
    before do
      @notification = create(:notification)
    end

    it "visitor_idがvisited_idをフォローした場合、visited_idに通知が登録される" do
      expect(@notification).to be_valid  # item.valid? が true になればパスする
    end
    
    it "visitor_idがvisited_idの投稿にコメントした場合、visited_idに通知が登録される" do
      @comment_notification = create(:notification, :comment)
      expect(@comment_notification).to be_valid
    end
    
    it "visitor_idがvisited_idの投稿にいいねした場合、visited_idに通知が作成される" do
      @like_notification = create(:notification, :like)
      expect(@like_notification).to be_valid
    end
  end
end
