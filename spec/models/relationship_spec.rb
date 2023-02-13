# frozen_string_literal: true

require "rails_helper"

RSpec.describe Relationship, type: :model do
  describe "会員をフォローする" do
    it "ログイン中の会員が他の会員をフォローできるできること" do
      expect(FactoryBot.create(:relationship)).to be_valid  # comment.valid? が true になればパスする
    end
  end
end
