#!/usr/bin/env ruby

require 'bundler/setup'
require_relative '../src/base'

scraper = Scraper::Scraper.new

# scraper.scrape_fixtures_and_results(
# 	'https://www.espncricinfo.com/series/icc-men-s-t20-world-cup-2024-1411166/match-schedule-fixtures-and-results',
# 	'fixtures_and_results.csv'
# )

scraper.scrape_squads(
	'https://www.espncricinfo.com/series/icc-men-s-t20-world-cup-2024-1411166/squads',
	'squads.csv'
)

scraper.finalize
