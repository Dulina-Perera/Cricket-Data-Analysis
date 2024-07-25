# lib/base/scraper.rb

require 'csv'
require_relative 'navigator'
require_relative 'extractor'
require_relative '../../config/constants'
require_relative 'match'

module Base
	class Scraper
		def initialize
			@navigator = Navigator.new(driver_type = :chrome)

			@extractor = Extractor.new
			@match_builder = MatchBuilder.new
		end

		# def scrape_fixtures_and_results(url, output_file)
		# 	driver = @navigator.initialize_driver
		# 	@navigator.navigate_to(driver, url)

		# 	types, groups, winners, win_by = @extractor.extract_descriptions_and_results(driver)
		# 	venues, dates = @extractor.extract_venues_and_dates(driver)

		# 	matches = []
		# 	for i in 0...types.size
		# 		match = @match_builder
		# 			.number(i + 1)
		# 			.type(types[i])
		# 			.group(groups[i])
		# 			.venue(venues[i])
		# 			.date(dates[i])
		# 			.winner(winners[i])
		# 			.win_by(win_by[i])
		# 			.build

		# 		matches << match
		# 	end

		# 	@extractor.extract_teams_and_innings(driver, matches)

		# 	save_fixtures_and_results_to_csv(matches, output_file)

		# 	driver.quit
		# 	puts "Data saved to #{output_file}."
		# end

		def scrape_squads(url, output_file)
			@navigator.driver.navigate.to(url)

			squads = []
			clickables = @navigator.driver.find_elements(css: '.ds-inline-flex.ds-items-start.ds-leading-none', tag_name: 'a')
			clickables.each do |clickable|
				if clickable.text =~ SQUAD_PATTERN
					squads << clickable.text
				end
			end

			squads.each do |squad|
				names, withdrawn, captain, vice_captain, roles = @extractor.extract_players_of_squad(@navigator, url, squad)
				puts names.size
				puts withdrawn.size
				puts captain.size
				puts vice_captain.size
				puts roles.size
			end

			@navigator.finalize
		end

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
