# lib/pages/page.rb

require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'uri'
require 'site_prism'
require 'vars'

# # workaround to keep browser alive for debugging after test completion
# Capybara::Selenium::Driver.class_eval do
#   def quit
#     puts "Press RETURN to quit the browser"
#     $stdin.gets
#     @browser.quit
#   rescue Errno::ECONNREFUSED
#     # Browser must have already gone
#   end
# end

class Page < SitePrism::Page
  include Capybara::DSL
  include Constants

  def initialize
    Capybara.current_driver = :selenium
    Capybara.app_host = 'https://www.ryanair.com/ie/en'
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_wait_time) do
      active = evaluate_script('jQuery.active')
      until active == 0
        active = evaluate_script('jQuery.active')
      end
    end
  end


  def waitwait(n=5)
    timeout = Time.now + n
    until Time.now > timeout end
  end
end
