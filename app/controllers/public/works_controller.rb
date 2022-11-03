class Public::WorksController < ApplicationController
  def index
    @work = Work.new
  end

  def show
  end
  
  def log
    @work = Work.new(work_params)
  end

  def edit
  end
  
  private
  
  def work_params
    params.require(:work).permit(:customer_id,:item_id,:amount_used)
  end
end
