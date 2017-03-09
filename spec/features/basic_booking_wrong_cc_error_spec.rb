# spec/features/basic_booking_wrong_cc_error.rb

require 'page'

feature "Verify basic booking with wrong CC number error" do

  background do
    @page = Home.new
    @page.navigate_to_home_page
    @page.fill_search_flight_form
  end

  # feature "test" do
  #   content "test" do
  #     scenario "test" do
  #       expect(@page.first_result_title).to include(keyword.capitalize)
  #     end
  #   end
  # end



















end
