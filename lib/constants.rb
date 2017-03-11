# lib/vars.rb

module Constants
  # credentials
  LOGIN = 'testtest@mailinator.com'
  PASSWORD = 'testT3ST'

  # destinations
  DEPARTURE = 'wroclaw'
  DESTINATION = 'warsaw'

  # passengers names
  TITLE = 'Ms'
  FIRST_NAME = 'first name'
  LAST_NAME = 'last name'

  #payment info
  PHONE_COUNTRY = 'Poland'
  PHONE_NUMBER = '1234567890'
  CC_NUMBER = '5105105105105100'
  CC_TYPE = 'MasterCard'
  CC_MONTH = '2'
  CC_YEAR = '2020'
  CC_CVV = '123'
  CC_HOLDER_NAME = 'Test Test'
  ADDRESS_LINE_1 = 'Test Test'
  ADDRESS_LINE_2 = 'Test Test'
  CITY = 'Wroclaw'
  POSTCODE = '12-345'
  COUNTRY = 'Poland'

  # payment error
  ERROR_TEXT = "Oh. There was a problem As your payment was not authorised we "\
               "could not complete your reservation. Please ensure that the "\
               "information was correct or use a new payment to try again"
end
