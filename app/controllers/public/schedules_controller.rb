class Public::SchedulesController < ApplicationController
  before_action :authenticate_customer!

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

  def schedule_params
    params.require(:schedule).permit(:schedule_title,:schedule_content,:start_time)
  end
end
