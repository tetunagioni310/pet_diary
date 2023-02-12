require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'ペット登録' do
    before do
      @schedule = create(:schedule)
    end
    
    it '有効なペット情報の場合は保存されるか' do
      expect(@schedule).to be_valid  # schedule.valid? が true になればパスする
    end
    
    it 'schedule_titleが空欄の場合、登録できない' do
      @schedule.schedule_title = nil
      @schedule.valid?
      expect(@schedule.errors.full_messages).to include('スケジュール名を入力してください')
    end
    
    it 'schedule_contentが空欄の場合、登録できない' do
      @schedule.schedule_content = nil
      @schedule.valid?
      expect(@schedule.errors.full_messages).to include('内容を入力してください')
    end
    
  end
end