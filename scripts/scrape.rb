#!/usr/bin/env ruby

require 'bundler/setup'
require_relative '../src/base'

scraper = Scraper::Scraper.new

# scraper.scrape_fixtures_and_results(
# 	'https://www.espncricinfo.com/series/icc-men-s-t20-world-cup-2024-1411166/match-schedule-fixtures-and-results',
# 	'matches.csv'
# )

scraper.scrape_player_details_and_stats(
	'https://www.espncricinfo.com/series/icc-men-s-t20-world-cup-2024-1411166/squads',
	'https://www.espncricinfo.com/records/tournament/icc-men-s-t20-world-cup-2024-15946',
	'players.csv'
)

# scraper.scrape_records(
# 	'https://www.espncricinfo.com/records/tournament/icc-men-s-t20-world-cup-2024-15946'
# )

scraper.finalize
