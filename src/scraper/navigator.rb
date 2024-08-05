# src/scraper/navigator.rb

require 'selenium-webdriver'

module Scraper
	class Navigator
		attr_reader :driver

		def initialize(driver_type)
			@driver = initialize_driver(driver_type)
		end

		def finalize
			@driver.quit if @driver
		end

		private

		def initialize_driver(driver_type)
			case driver_type
			when :chrome
				options = Selenium::WebDriver::Options.chrome
				options.add_argument('--headless')
				Selenium::WebDriver.for(:chrome, options: options)
			when :firefox
				options = Selenium::WebDriver::Options.firefox
				options.add_argument('--headless')
				Selenium::WebDriver.for(:firefox, options: options)
			else
				raise "Unsupported driver type: #{driver_type}\nSupported types: :chrome, :firefox"
			end
		end
	end
end
