require 'csv'
require 'selenium-webdriver'

options = Selenium::WebDriver::Firefox::Options.new()
options.add_argument('--headless')
driver = Selenium::WebDriver.for(:firefox, options: options)

driver.navigate.to('https://www.espncricinfo.com/series/icc-men-s-t20-world-cup-2024-1411166/match-schedule-fixtures-and-results')

group_match_pattern = /^.*?Group\s*([a-zA-Z]).*$/
super_eight_match_pattern = /^.*?Super Eights,\s*Group\s*(\d).*$/
semi_final_match_pattern = /^.*?Semi-Final.*$/
venue_pattern = /^.*?•\s*(.*?),\s*ICC.*$/
result_pattern = /^(.*?)\s*won\s*by\s*(.*)$/

Match = Struct.new(:match_number, :type, :group, :venue, :team_1, :team_2, :inning_1, :inning_2, :winner, :win_by)
matches = []

descriptions_and_results = driver.find_elements(css: '.ds-text-tight-s.ds-font-medium.ds-text-typo')
venues = driver.find_elements(css: '.ds-text-tight-s.ds-font-regular.ds-truncate.ds-text-typo-mid3')
match_number = 1

descriptions_and_results.each_slice(2) do |description_and_result|
  description = description_and_result[0].text
  result = description_and_result[1].text

  match = Match.new(match_number: match_number, type: nil, group: nil, venue: nil, team_1: nil, team_2: nil, inning_1: nil, inning_2: nil, winner: nil, win_by: nil)

  if description =~ group_match_pattern
    match.group = $1
    match.type = 'Group'
  elsif description =~ super_eight_match_pattern
    match.group = $1
    match.type = 'Super Eights'
  elsif description =~ semi_final_match_pattern
    match.type = 'Semi-Final'
  else
    match.type = 'Final'
  end

  if result =~ result_pattern
    match.winner = $1
    match.win_by = $2
  end

  matches << match
  match_number += 1

  # puts(match.to_h)
end

for i in 0...matches.length
  if venues[i].text =~ venue_pattern
    matches[i].venue = $1
  end
end

parent_elements = driver.find_elements(css: '.ci-team-score').last(2 * matches.length)

idx = 0
parent_elements.each_slice(2) do |parent_element|
  matches[idx].team_1 = parent_element[0].find_elements(tag_name: 'div')[0].attribute('title')
  matches[idx].team_2 = parent_element[1].find_elements(tag_name: 'div')[0].attribute('title')

  temp = parent_element[0].find_elements(tag_name: 'div')[1]
  if temp
    matches[idx].inning_1 = temp.find_element(tag_name: 'strong').text
  end

  temp = parent_element[1].find_elements(tag_name: 'div')[1]
  if temp
    matches[idx].inning_2 = temp.find_element(tag_name: 'strong').text
  end

  idx += 1
end

CSV.open('matches.csv', 'w+', write_headers: true, headers: %w[Match_Number Type Group Venue Team_1 Team_2 Inning_1 Inning_2 Winner Win_By]) do |csv|
  matches.each do |match|
    csv << match.to_h.values
  end
end

driver.quit()
