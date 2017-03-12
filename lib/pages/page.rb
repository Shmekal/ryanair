# lib/pages/page.rb

require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'uri'
require 'site_prism'
require 'constants'

class Page < SitePrism::Page
  include Capybara::DSL
  include Constants

  def initialize
    Capybara.current_driver = :chrome # :chrome | :firefox
    Capybara.app_host = 'https://www.ryanair.com/ie/en'
  end
end
