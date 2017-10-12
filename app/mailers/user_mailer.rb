class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def receipt_email(order)
    @order  = order
    mail(to: @order.email, subject: "Order Number: #{@order.id}")
  end
end
