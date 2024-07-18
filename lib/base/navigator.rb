# lib/base/navigator.rb

require 'selenium-webdriver'

module Base
	# This class is responsible for navigating to web pages.
	class Navigator
		# Initializes the driver for web scraping.
		#
		# @return [Selenium::WebDriver] The initialized driver
		def initialize_driver
			options = Selenium::WebDriver::Firefox::Options.new()
			options.add_argument('--headless')

			Selenium::WebDriver.for(:firefox, options: options)
		end

		# Navigates to the specified URL using the given driver.
		#
		# @param driver [Selenium::WebDriver] The driver to use for navigation
		# @param url [String] The URL to navigate to
		def navigate_to_page(driver, url)
			driver.navigate.to(url)
		end
	end
end
