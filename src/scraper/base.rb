# src/scraper/base.rb

require 'csv'
require_relative 'navigator'
require_relative 'extractor'

module Scraper
	class Scraper
		def initialize
			@navigator = Navigator.new(driver_type = :chrome)
		end

		def scrape_fixtures_and_results(url, output_file)
			extractor = FixturesAndResultsExtractor.new(@navigator.driver)

			matches = extractor.extract(url)

			save_fixtures_and_results_to_csv(matches, output_file)
			puts "Fixtures and results saved to #{output_file}"
		end

		# def scrape_squads(url, output_file)
		# 	@navigator.driver.navigate.to(url)

		# 	squads = []
		# 	clickables = @navigator.driver.find_elements(css: '.ds-inline-flex.ds-items-start.ds-leading-none', tag_name: 'a')
		# 	clickables.each do |clickable|
		# 		if clickable.text =~ SQUAD_PATTERN
		# 			squads << clickable.text
		# 		end
		# 	end

		# 	squads.each do |squad|
		# 		names, withdrawn, captain, vice_captain, roles = @extractor.extract_players_of_squad(@navigator, url, squad)
		# 		puts names.size
		# 		puts withdrawn.size
		# 		puts captain.size
		# 		puts vice_captain.size
		# 		puts roles.size
		# 	end

		# 	@navigator.finalize
		# end

		private

		def save_fixtures_and_results_to_csv(matches, filename)
			CSV.open(filename, 'w+', write_headers: true, headers: %w[Match_Number Type Group Venue Date Team_1 Team_2 Inning_1 Inning_2 Winner Win_By]) do |csv|
				matches.each do |match|
					csv << match.to_h.values
				end
			end
		end
	end
end
