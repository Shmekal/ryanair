# lib/pages/extras.rb

require 'pages/page.rb'

class ReserveSeatSection < SitePrism::Section
  element :choose_seat_btn, '[ng-click^="confirm"]'
  element :cancel_btn, '[ng-click^="closeThisDialog"]'
end

class Extras < Page
  set_url '/booking/extras'

  section :reserve_seat_widget, ReserveSeatSection, '.seat-prompt-popup-content'
  section :cart, '.cart.cart' do
    element :check_out_btn, 'button>span'
  end
  element :pick_seats_offer, '.section-seats'

  def initialize
    wait_for_cart(10)
  end

  def proceed_to_check_out
    wait_for_pick_seats_offer(10)
    execute_script "window.scrollBy(0,-1000)"
    cart.check_out_btn.click
    wait_for_reserve_seat_widget(3)
    reserve_seat_widget.cancel_btn.click if has_reserve_seat_widget?
    Payment.new
  end

end
