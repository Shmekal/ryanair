# lib/pages/home.rb

require 'pages/page'

class SuggestionsListSection < SitePrism::Section
  section :airports_list, '[class="pane right"]' do
    element :first_result, '.core-list-small'
  end
end

class DatePickerSection < SitePrism::Section
  element :day_out, '.calendar-view:first-of-type .days li:last-of-type'
  element :day_back, '.calendar-view:last-of-type .days li:last-of-type'
end

class PassengerOptionsSection < SitePrism::Section
  sections :psngr_type, 'div[passenger-detail]' do
    element :substract, '[ng-click$="decrement()"]'
    element :add, '[ng-click$="increment()"]'
  end
end

class Home < Page
  set_url 'https://www.ryanair.com/ie/en/'

  section :search_flight, '.search-container' do
    section :suggestions_list, SuggestionsListSection, 'core-linked-list'
    section :datepicker, DatePickerSection, '.datepicker-wrapper>ul'
    section :psngrs_opts, PassengerOptionsSection, '.col-passengers .content'

    element :departure, '.disabled-wrap [placeholder^="Departure"]'
    element :destination, '.disabled-wrap [placeholder^="Destination"]'
    element :date_out, '.col-cal-from .date-input'
    element :date_back, '.col-cal-to .date-input'
    element :passengers, '[label="Passengers:"] .value'
    element :lestsgo_btn, '.core-btn-primary[ng-click^="searchFlights"]'
  end

  def navigate_to_home_page
    self.load
  end

  def fill_search_flight_form
    wait_for_search_flight(3)
    search_flight.departure.set DEPARTURE
    search_flight.suggestions_list.wait_for_airports_list(3)
    search_flight.suggestions_list.airports_list.first_result.click

    search_flight.destination.set DESTINATION
    search_flight.suggestions_list.wait_for_airports_list(3)
    search_flight.suggestions_list.airports_list.first_result.click

    execute_script "window.scrollBy(0,300)"
    search_flight.wait_for_datepicker(3)
    search_flight.datepicker.day_out.click
    search_flight.wait_for_datepicker(3)
    search_flight.datepicker.day_back.click

    search_flight.passengers.click
    search_flight.wait_for_psngrs_opts(3)
    search_flight.psngrs_opts.psngr_type[0].add.click
    2.times { search_flight.psngrs_opts.psngr_type[1].add.click }

    search_flight.lestsgo_btn.click
    Booking.new
  end
end
