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
    Capybara.current_driver = :selenium
    Capybara.app_host = 'https://www.ryanair.com/ie/en'
  end

  # METHODS BELOW - looking for solution with waiting for elements
  # TO BE REMOVED - couldn't make it work
  def wait_for_ajax
    Timeout.timeout(Capybara.default_wait_time) do
      active = evaluate_script('jQuery.active')
      until active == 0
        active = evaluate_script('jQuery.active')
      end
    end
  end

# TO BE REMOVED - sleeps are inapropriate
  def waitwait(n=5)
    timeout = Time.now + n
    until Time.now > timeout; end
  end
end
