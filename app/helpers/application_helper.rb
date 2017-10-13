module ApplicationHelper

  def avg_review(product)
    if @product.reviews.empty?
      'Be the first to review this product!'
    else
      @sum_rating = 0
      product.reviews.each do |review|
        @sum_rating += review.rating
      end
      @avg_review = @sum_rating / product.reviews.size
    end
  end

end
