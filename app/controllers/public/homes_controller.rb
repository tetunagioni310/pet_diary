class Public::HomesController < ApplicationController
  def top
    @posts = Post.order(id: :desc).limit(6)
    if customer_signed_in?
      @following_customer_posts = Post.where(customer_id: [*current_customer.following_ids]).order(id: "DESC").limit(10)
    end
  end

  def about
  end
  
 
end
