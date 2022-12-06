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
      flash[:notice] = "スケジュールを作成しました…"
      redirect_to public_schedules_path
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
    @schedule.update(schedule_params)
    flash[:notice] = "投稿を更新しました"
    redirect_to public_schedule_path(@schedule.id)
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    flash[:notice] = "スケジュールを削除しました…"
    redirect_to public_schedules_path
  end

  private
  # カレンダーを表示するときに先頭を日曜日に並べ直す
  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end

  def schedule_params
    params.require(:schedule).permit(:schedule_title,:schedule_content,:start_time)
  end
end
