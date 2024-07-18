# lib/base/scraper.rb

require 'csv'
require_relative 'navigator'
require_relative 'extractor'
require_relative '../../config/constants'
require_relative 'match'

module Base
	# This class is responsible for scraping web pages.
	class Scraper
		def initialize
			@navigator = Navigator.new
			@extractor = Extractor.new
		end

		# Scrapes the given URL and saves the extracted data to a CSV file.
		#
		# @param url [String] The URL of the web page to scrape.
		# @param output_file [String] The path to the output CSV file.
		def scrape(url, output_file)
			driver = @navigator.initialize_driver
			@navigator.navigate_to_page(driver, url)

			# Extract descriptions and results from the web page
			descriptions_and_results = @extractor.extract_descriptions_and_results(driver)

			# Extract venues from the web page
			venues = @extractor.extract_venues(driver)

			# Parse matches from the extracted descriptions and results
			matches = @extractor.parse_matches(descriptions_and_results)

			# Associate venues with the matches
			@extractor.extract_venues_for_matches(matches, venues)

			# Extract teams and innings for each match
			@extractor.extract_teams_and_innings(driver, matches)

			# Save the matches to a CSV file
			save_matches_to_csv(matches, output_file)

			driver.quit
			puts "Data saved to #{output_file}."
		end

		private

		# Saves the matches to a CSV file.
		#
		# @param matches [Array<Match>] The array of Match objects to save.
		# @param filename [String] The path to the output CSV file.
		def save_matches_to_csv(matches, filename)
			CSV.open(filename, 'w+', write_headers: true, headers: %w[Match_Number Type Group Venue Team_1 Team_2 Inning_1 Inning_2 Winner Win_By]) do |csv|
				matches.each do |match|
					csv << match.to_h.values
				end
			end
		end
	end
end
