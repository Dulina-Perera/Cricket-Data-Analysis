# src/scraper/base.rb

require 'csv'
require_relative 'navigator'
require_relative 'extractor'

module Scraper
	class Scraper
		attr_reader :players

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

		def scrape_player_details_and_stats(
			details_url,
			stats_url,
			output_file
		)
			extractor = PlayersExtractor.new(@navigator.driver)

			players = extractor.extract(details_url, stats_url)

			save_players_to_csv(players, output_file)
			puts "Players saved to #{output_file}"
		end

		def scrape_records(url)
			extractor = RecordsExtractor.new(@navigator.driver)

			extractor.extract(url)
		end

		private

		def save_fixtures_and_results_to_csv(fixtures_and_results, filename)
			CSV.open(filename, 'w+', write_headers: true, headers: %w[Match_Number Type Group Venue Date Team_1 Team_2 Inning_1 Inning_2 Winner Win_By]) do |csv|
				fixtures_and_results.each do |fixture_and_result|
					csv << fixture_and_result.to_h.values
				end
			end
		end

		def save_players_to_csv(players, filename)
			CSV.open(filename, 'w+', write_headers: true, headers: %w[Name Team Role Has_Withdrawn Is_Captain Is_ViceCaptain Age Batting_Style Bowling_Style Matches_Played Innings_Batted Notouts Runs_Scored Balls_Faced Highest_Score Batting_Average Batting_Strike_Rate Hundreds Fifties Ducks Fours Sixes]) do |csv|
				players.each do |player|
					csv << player.to_h.values
				end
			end
		end
	end
end
