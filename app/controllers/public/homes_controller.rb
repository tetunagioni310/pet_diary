class Public::HomesController < ApplicationController

  def top
    @posts = Post.order(id: :desc).limit(6)
    @random_posts = Post.order("RANDOM()").limit(10)
  end

  def about
  end


end
