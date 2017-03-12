# spec/features/basic_booking_wrong_cc_error.rb

require 'spec_helper'

feature "Make basic booking" do
  context "for 2 adults and 2 teens" do
    context "use invalid credit card" do
      scenario "Error should arise after submitting payment form" do
        # home
        @page = Home.new
        @page.navigate_to_home_page
        @page = @page.fill_search_flight_form
        # booking
        expect(@page).to have_selector('.flights-table .flight-header')
        @page.choose_time_and_class(:to)
        expect(@page).not_to have_selector('.flights-table-fares__wrapper')
        @page.choose_time_and_class(:from)
        expect(@page).not_to have_selector('#continue[disabled="disabled"]')
        @page = @page.submit_time_and_class_form
        # extra
        @page = @page.proceed_to_check_out
        # payment
        @page.log_in(LOGIN, PASSWORD)
        expect(@page).not_to have_selector('.login-register-checkout-compact')
        @page.fill_in_passenger_details
        @page.fill_in_payment_and_contact_details
        # error validation
        expect(@page.verify_error).to include(ERROR_TEXT)
      end
    end
  end
end
