class Public::HomesController < ApplicationController

  def top
    @posts = Post.joins(:customer).where(customers: { status: 1 }).order(id: :desc).limit(5)
    @order_posts = Post.joins(:customer).where(customers: { status: 1 })
    # @order_posts = Post.joins(:customer).where(customers: { status: 1 }).where('(id & 255) = ?', rand(256)).order(Arel.sql('RANDOM')).limit(10)
  end

  def about
  end
  
end
