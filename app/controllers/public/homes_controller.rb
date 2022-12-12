class Public::HomesController < ApplicationController

  def top
    # 画像がついている投稿だけ取り出したい
    @posts = Post.order(id: :desc).limit(10)
    @random_posts = Post.order("RANDOM()").limit(10)
  end

  def about
  end


end
