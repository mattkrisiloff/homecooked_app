class ChargesController < ApplicationController
  def new
  end
  
  def create
    #amount in cents
    @amount = 1000
    
    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => params[:stripeToken]
    )
    
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails stripe customer',
      :currency    => 'usd'
    )
    
    redirect_to static_pages_purchased_path
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
