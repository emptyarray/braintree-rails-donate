require 'spec_helper'

feature "Donation button" do
  scenario "visit index" do
    visit root_url
    page.should have_button "Donate"
  end
  
  scenario "button goes to new donation page" do
    visit root_url
    click_button("Donate")
    current_path.should == new_donation_path
  end
  
  # Use Selenium, the default JS, to follow the JS redirect
  scenario "successful donation", :js => true do
    visit new_donation_path
    
    select "$10.00", :from => "Amount"
    fill_in "First Name", :with => "Johnny"
    fill_in "Number", :with => "4111111111111111"
    fill_in "Expiration Date (MM/YY)", :with => "12/2015"
    click_on "Submit"
    
    page.should have_content "Thank you"
  end
  
  scenario "missing expiration date", :js => true do
    visit new_donation_path
  
    select "$10.00", :from => "Amount"
    fill_in "First Name", :with => "Johnny"
    fill_in "Number", :with => "4111111111111111"
    fill_in "Expiration Date (MM/YY)", :with => ""
    click_on "Submit"
  
    page.should have_content "Expiration date is required"
  end
end