# spec/features/basic_booking_wrong_cc_error.rb

require 'pages/home'
require 'pages/booking'
require 'pages/extras'
require 'pages/payment'
include Constants

feature "Verify basic booking with wrong CC number error" do

  background do
    @page = Home.new
    @page.navigate_to_home_page
    @page = @page.fill_search_flight_form
    @page = @page.choose_time_and_class
    @page = @page.proceed_to_check_out
    @page.log_in(LOGIN, PASSWORD)
    @page.fill_in_passenger_details
    @page.fill_in_payment_and_contact_details
  end

  feature "Basic booking for 2 adults and 2 children" do
    context "Using invalid credit card" do
      scenario "Error should arise after submitting payment form" do
        expect(@page.verify_error).to include(ERROR_TEXT)
      end
    end
  end
end
