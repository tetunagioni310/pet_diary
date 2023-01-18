class Public::HomesController < ApplicationController

  def top
    # 画像がついている投稿だけ取り出したい
    @posts = Post.joins(:customer).where(customers: { status: 1 }).order(id: :desc).limit(5)
    @random_posts = Post.joins(:customer).where(customers: { status: 1 }).sample(10)
  end

  def about
  end
  
end
