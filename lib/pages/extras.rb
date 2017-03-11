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

  def initialize
    wait_for_cart(10)
  end

  def proceed_to_check_out
    execute_script "window.scrollBy(0,-1000)"
waitwait
    cart.wait_for_check_out_btn(3)
    cart.check_out_btn.click
    wait_for_reserve_seat_widget(3)
    reserve_seat_widget.cancel_btn.click if has_reserve_seat_widget?
    Payment.new
  end

end
