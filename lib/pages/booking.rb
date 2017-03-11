# lib/pages/booking.rb

require 'pages/page'


class FamilyExtraWidgetSection < SitePrism::Section
  element :continue, '.core-btn-primary'
end

class FlightFaresSection < SitePrism::Section
  sections :classes, '[ng-repeat^="fare"]' do
    element :select_btn, '#continue'
  end
end


class Booking < Page
  set_url '/booking/home'
  section :family_extra_widget, FamilyExtraWidgetSection, '.modal-dialog.family'
  sections :flight_list, '.flights-table' do
    section :flight_fares, FlightFaresSection, '.flights-table-fares__wrapper'
    elements :flights, '.flight-header'
  end
  element :continue_btn_bottom, '#continue'
  element :continue_btn_disabled, '#continue[disabled="disabled"]'

  def initialize
    wait_for_flight_list(10)
    family_extra_widget.continue.click if has_family_extra_widget?
    # wait_for_ajax
  end

  def choose_time_and_class
waitwait(5)
    flight_list.first.flights.first.click
    flight_list.first.wait_for_flight_fares(3)
    flight_list.first.flight_fares.classes.first.select_btn.click
waitwait(2)
    flight_list.first.wait_until_flight_fares_invisible(5)

    flight_list.last.flights.first.click
    flight_list.last.wait_for_flight_fares(3)
    flight_list.last.flight_fares.classes.first.select_btn.click
waitwait(2)
    flight_list.last.wait_until_flight_fares_invisible(3)

    wait_until_continue_btn_disabled_invisible(5)
    continue_btn_bottom.click
    Extras.new
  end
end
