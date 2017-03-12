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
  element :continue_btn_bottom, '[class$="footer"]>button#continue'
  element :continue_btn_disabled, '#continue[disabled="disabled"]'

  def initialize
    wait_for_flight_list(10)
    family_extra_widget.continue.click if has_family_extra_widget?
  end

  def choose_time_and_class(dir)
    i = dir == :to ? 0 : 1
    flight_list[i].flights.first.click
    flight_list[i].flight_fares.classes.first.wait_for_select_btn
    flight_list[i].flight_fares.classes.first.select_btn.click
    # t = Time.now + 2
    # until Time.now > t ; end
    # flight_list.last.flights.first.click
    # flight_list.last.flight_fares.classes.first.wait_for_select_btn
    # flight_list.last.flight_fares.classes.first.select_btn.click
  end

  def submit_time_and_class_form
    continue_btn_bottom.click
    Extras.new
  end
end
