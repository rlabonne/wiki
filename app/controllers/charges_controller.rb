class ChargesController < ApplicationController
  def new
    # Amount in cents
    @amount = 1000

    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Wiki Premium - #{current_user.username}",
      amount: @amount
    }
  end

  def create
    # Amount in cents
    @amount = 1000

    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount,
      description: "Wiki Premium - #{current_user.email}",
      currency: 'usd'
    )

    current_user.premium!

    flash[:notice] = "Thanks for upgrading, #{current_user.username}!"
    redirect_to wikiis_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def downgrade_account
    current_user.standard!
    flash[:notice] = "Your account has been downgraded back to standard."
    redirect_to root_path
  end

end
