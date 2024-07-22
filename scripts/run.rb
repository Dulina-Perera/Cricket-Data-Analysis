#!/usr/bin/env ruby

require 'bundler/setup'
require_relative '../lib/base'

url = 'https://www.espncricinfo.com/series/icc-men-s-t20-world-cup-2024-1411166/match-schedule-fixtures-and-results'
output_file = 'matches.csv'

scraper = Base::Scraper.new
scraper.scrape(url, output_file)
