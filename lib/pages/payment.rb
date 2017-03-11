# lib/pages/payment.rb

require 'pages/page.rb'

class LoginRegisterSection < SitePrism::Section
  element :signup_btn, '[ui-sref="register"]'
  element :login_btn, '[ui-sref="login"]'
end

class SignupModalSection < SitePrism::Section
  element :email, 'input[type="email"]'
  element :password, '[name="password"]'
  element :log_in_btn, '[type="submit"]'
end

class PassengerDetailsSection < SitePrism::Section
  element :title, '[id^="title"]'
  element :first_name, '[class$="first-name"]>input'
  element :last_name, '[class$="last-name"]>input'
end

class Payment < Page
  set_url "/booking/payment"

  section :signup_modal, SignupModalSection, '.signup-modal'
  section :login_register, LoginRegisterSection, '.login-register-checkout-compact'
  section :main_area, '.main-area' do
    sections :passenger_details, '.pax-form-element' do
      element :title, '[id^="title"]'
      element :first_name, '[class$="first-name"]>input'
      element :last_name, '[class$="last-name"]>input'
    end
    element :phone_country, '[name="phoneNumberCountry"]'
    element :phone_number, '.phone-number input'
    element :cc_number, '.card-seats-flow input'
    element :cc_type, '[id^="cardType"]'
    element :cc_month, '.expiry-month-select'
    element :cc_year, '.expiry-year-select'
    element :cc_cvv, '.card-security-code input'
    element :cc_holder_name, '.cardholder'
    element :address_line_1, '[id$="AddressLine1"]'
    element :address_line_2, '[id$="AddressLine2"]'
    element :city, '[id$="City"]'
    element :postcode, '[id$="Postcode"]'
    element :country, '[id$="Country"]'
    element :accept_terms, '.terms input'
    element :pay_now, 'button'
    section :error, '[ng-if="pf.serverError"]' do
      element :error_msg, '.error'
    end
  end

  def initialize
    wait_for_main_area(10)
  end

  def log_in(login='testtest@mailinator.com', password='testT3ST')
    login_register.login_btn.click
    wait_for_signup_modal(3)
    signup_modal.email.set login
    signup_modal.password.set password
    signup_modal.log_in_btn.click
    wait_until_signup_modal_invisible(5)
  end

  def fill_in_passenger_details
waitwait(2)
    main_area.passenger_details.each_with_index do |passenger, i|
      n = %w(one two three four)
      passenger.title.select('Ms')
      passenger.first_name.set "first name #{n[i]}"
      passenger.last_name.set "last name #{n[i]}"
    end
  end

  def fill_in_payment_and_contact_details
    main_area.phone_country.select("Poland")
    main_area.phone_number.set '1234567890'
    main_area.cc_number.set '5105105105105100'
    main_area.cc_type.select('MasterCard')
    main_area.cc_month.select('2')
    main_area.cc_year.select('2020')
    main_area.cc_cvv.set '123'
    main_area.cc_holder_name.set 'Test Test'
    main_area.address_line_1.set 'Test Test'
    main_area.address_line_2.set 'Test Test'
    main_area.city.set 'Wroclaw'
    main_area.postcode.set '12-345'
    main_area.country.select('Poland')
    main_area.accept_terms.click
    execute_script "window.scrollBy(0,300)"
    main_area.pay_now.click
  end

  def verify_error
    main_area.wait_for_error(10)
    main_area.error.error_msg.text
  end

end
