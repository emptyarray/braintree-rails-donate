class DonationsController < ApplicationController
  def index
    @notice = flash[:notice]   
  end
  
  def new
    @result_params = flash[:result_params]
    @result_errors = flash[:result_errors]
    @result_message = flash[:result_message]
    
    @sandbox_card_number = "4111111111111111"
    @default_name = "Bob"
    @sandbox_expiration = "12/2015"
    @amounts = ["5.00", "10.00"]
    
    
    @tr_data = Braintree::TransparentRedirect.transaction_data(
      :redirect_url => confirm_donations_url,
      :transaction => {:type => "sale"}
    )
  end
  
  def confirm
    
    @result = Braintree::TransparentRedirect.confirm(request.query_string)
    
    if @result.success?
      customer_name = @result.transaction.customer_details.first_name
      transaction_id = @result.transaction.id
      redirect_to root_path, :notice => "Thank you, #{customer_name}! Your transaction ID is #{transaction_id}"
    else
      # need to split the result into components because it can't be serialized due to TypeError
      redirect_to new_donation_path, :flash => { 
        :result_params => @result.params[:transaction], 
        :result_errors => @result.errors.for(:transaction),
        :result_message => @result.message
      }
    end
  end
  
end
