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
    if @schedule.save
      flash[:notice] = "created an appointment…"
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
    redirect_to public_schedule_path(@schedule.id)
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to public_schedules_path
  end

  private

  def schedule_params
    params.require(:schedule).permit(:customer_id,:schedule_title,:schedule_content,:start_time)
  end
end
