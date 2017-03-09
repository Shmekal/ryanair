# lib/page.rb

require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'uri'
require 'site_prism'

# # workaround to keep browser alive for debugging after test completion
# Capybara::Selenium::Driver.class_eval do
#   def quit
#     puts "Press RETURN to quit the browser"
#     $stdin.gets
#     @browser.quit
#   rescue Errno::ECONNREFUSED
#     # Browser must have already gone
#   end
# end

class Page < SitePrism::Page
  include Capybara::DSL

  def inititalize
    Capybara.current_driver = :selenium
  end
end

class SearchFlightSection < SitePrism::Section
  section :suggestions_list, SuggestionsListSection, 'core-linked-list'
  section :datepicker, DatePickerSection, '.datepicker-wrapper'

  element :departure, '.disabled-wrap [placeholder^="Departure"]'
  element :destination, '.disabled-wrap [placeholder^="Destination"]'
  element :date_out, '.col-cal-from .date-input'
  element :date_back, '.col-cal-to .date-input'
  element :lestsgo_btn, '.core-btn-primary[ng-click^="searchFlights"]'
end

class SuggestionsListSection < SitePrism::Section
  section :airports_list, AirportsListSection, '[class="pane right"]'
end

class AirportsListSection < SitePrism::Section
  element :first_result, '.core-list-small'
end

class DatePickerSection < SitePrism::Section
  element :day_out, '.calendar-view:first-of-type .days li:last-of-type'
  element :day_back, '.calendar-view:last-of-type .days li:last-of-type'
end

class Home < Page
  set_url 'https://www.ryanair.com/ie/en/'
  section :search_flight, SearchFlightSection, '.search-container'

  def navigate_to_home_page
    self.load
  end

  def fill_search_flight_form
    wait_for_search_flight(3)
    search_flight.departure.set 'wroclaw'
    wait_for_suggestions_list(3)
    search_flight.suggestions_list.airports_list.first_result.click

    search_flight.destination.set 'warsaw'
    wait_for_suggestions_list(3)
    search_flight.suggestions_list.airports_list.first_result.click

  end



end
