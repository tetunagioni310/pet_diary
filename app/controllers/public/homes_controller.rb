class Public::HomesController < ApplicationController
  def top
    @posts = Post.joins(:customer).where(customers: { status: 1 }).order(id: :desc).limit(5)
    rand = Rails.env.production? ? 'rand()' : 'RANDOM()'
    @order_posts = Post.joins(:customer).where(customers: { status: 1 }).order(rand).limit(10)
  end

  def about; end
end
