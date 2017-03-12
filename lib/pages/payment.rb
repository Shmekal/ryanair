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
  include Constants

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
    element :accept_terms, '.cta label'
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
  end

  def fill_in_passenger_details
    main_area.wait_until_passenger_details_visible(5)
    main_area.passenger_details.each_with_index do |passenger, i|
      n = %w(one two three four)
      passenger.title.select('Ms')
      passenger.first_name.set "first name #{n[i]}"
      passenger.last_name.set "last name #{n[i]}"
    end
  end

  def fill_in_payment_and_contact_details
    main_area.phone_country.select(PHONE_COUNTRY)
    main_area.phone_number.set PHONE_NUMBER
    main_area.cc_number.set CC_NUMBER
    main_area.cc_type.select(CC_TYPE)
    main_area.cc_month.select(CC_MONTH)
    main_area.cc_year.select(CC_YEAR)
    main_area.cc_cvv.set CC_CVV
    main_area.cc_holder_name.set CC_HOLDER_NAME
    main_area.address_line_1.set ADDRESS_LINE_1
    main_area.address_line_2.set ADDRESS_LINE_2
    main_area.city.set CITY
    main_area.postcode.set POSTCODE
    main_area.country.select(COUNTRY)
    execute_script "window.scrollBy(0,300)"
    # main_area.wait_for_accept_terms(5)
    main_area.accept_terms.click
    main_area.pay_now.click
  end

  def verify_error
    main_area.wait_for_error(10)
    main_area.error.error_msg.text
  end

end
