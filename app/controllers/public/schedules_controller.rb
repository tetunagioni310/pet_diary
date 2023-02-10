class Public::SchedulesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_beginning_of_week

  def show
    @schedule = Schedule.find(params[:id])
  end

  def index
    @schedules = current_customer.schedules
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.customer_id = current_customer.id
    if @schedule.save
      redirect_to public_schedules_path, notice: 'スケジュールを作成しました。'
    else
      @schedules = current_customer.schedules
      render 'index'
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      redirect_to public_schedule_path(@schedule.id), notice: 'スケジュールを更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to public_schedules_path, notice: 'スケジュールを削除しました。'
  end
  
  # スケジュールが3つ以上作成された時リストとして表示される
  def schedule_list
    # 送信されてきた日付を[in_time_zone]でアプリケーション側の時間に変換したのち
    start_time = params[:date].in_time_zone
    end_time = params[:date].in_time_zone.end_of_day
    @schedules = current_customer.schedules.where('start_time >=? AND start_time <= ?', start_time, end_time)
  end

  private

  # カレンダーを表示するときに先頭を日曜日に並べ直す
  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end

  def schedule_params
    params.require(:schedule).permit(:schedule_title, :schedule_content, :start_time)
  end
end
