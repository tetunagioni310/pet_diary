class Public::HomesController < ApplicationController

  def top
    @posts = Post.joins(:customer).where(customers: { status: 1 }).order(id: :desc).limit(5)
    
    # @order_posts = Post.joins(:customer).where(customers: { status: '1' }).where('(posts.id & 255) = ?', rand(1..256)).limit(10)
     @order_posts = Post.joins(:customer).where(customers: { status: '1' })
    # @order_posts = Post.joins(:customer).where(customers: { status: '1' }).order(Arel.sql('RANDOM()')).limit(10)

    # @released_posts = Post.joins(:customer).where(customers: { status: 1 })
    # @order_posts = @released_posts.where('(id & 255) = ?', rand(256)).order(Arel.sql('RANDOM()')).limit(8)
    # byebug
  end

  def about
  end
  
end
