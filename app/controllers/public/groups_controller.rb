class Public::GroupsController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @group = Group.find(params[:id])
    
    groups = Group.all
    groups.each do |group|
      case group.group_name
      when '犬'
        @dog_group = group
      when '猫'
        @cat_group = group
      when 'その他'
        @other_group = group
      end
    end

    case @group.group_name
      when '犬'
        @dog_post_all = Post.released_post_group(@group)
        @dog_posts = Post.released_post_group(@group).order(id: 'DESC').page(params[:dog_posts_page]).per(8)
      when '猫'
        @cat_post_all = Post.released_post_group(@group)
        @cat_posts = Post.released_post_group(@group).order(id: 'DESC').page(params[:cat_posts_page]).per(8)
      when 'その他'
        @other_post_all = Post.released_post_group(@group)
        @other_posts = Post.released_post_group(@group).order(id: 'DESC').page(params[:other_posts_page]).per(8)
    end
  end
  
end