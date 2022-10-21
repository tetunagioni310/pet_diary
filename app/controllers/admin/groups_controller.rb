class Admin::GroupsController < ApplicationController

  def index
    @groups = Group.all
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.save
    redirect_to admin_groups_path
  end
  
  private
  def group_params
    params.require(:group).permit(:group_name)
  end
end