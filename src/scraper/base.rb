# src/scraper/base.rb

require 'csv'
require_relative 'navigator'
require_relative 'extractor'

module Scraper
	class Scraper
		def initialize
			@navigator = Navigator.new(driver_type = :chrome)
		end

		def finalize
			@navigator.finalize
		end

		def scrape_fixtures_and_results(url, output_file)
			extractor = FixturesAndResultsExtractor.new(@navigator.driver)

			fixtures_and_results = extractor.extract(url)

			save_fixtures_and_results_to_csv(fixtures_and_results, output_file)
			puts "Fixtures and results saved to #{output_file}"
		end

		def scrape_squads(url, output_file)
			extractor = SquadsExtractor.new(@navigator.driver)

			squads = extractor.extract(url)

			save_squads_to_csv(squads, output_file)
			puts "Squads saved to #{output_file}"
		end

		private

		def save_fixtures_and_results_to_csv(fixtures_and_results, filename)
			CSV.open(filename, 'w+', write_headers: true, headers: %w[Match_Number Type Group Venue Date Team_1 Team_2 Inning_1 Inning_2 Winner Win_By]) do |csv|
				fixtures_and_results.each do |fixture_and_result|
					csv << fixture_and_result.to_h.values
				end
			end
		end

		def save_squads_to_csv(squads, filename)
			CSV.open(filename, 'w+', write_headers: true, headers: %w[Name Team Role Has_Withdrawn Is_Captain Is_ViceCaptain Age Batting_Style Bowling_Style]) do |csv|
				squads.each do |squad|
					csv << squad.to_h.values
				end
			end
		end
	end
end
