# frozen_string_literal: true

class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  # seedでデフォルト値を作成されるため、使用しない
  def index
    @groups = Group.all
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.save
    redirect_to admin_groups_path
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to admin_groups_path
    else
      render "edit"
    end
  end

  def destroy
    @group = Group.find_by(id: params[:id])
    @group.destroy
    redirect_to admin_groups_path
  end

  private
    def group_params
      params.require(:group).permit(:group_name)
    end
end
