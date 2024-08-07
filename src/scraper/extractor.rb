# lib/base/extractor.rb

require_relative '../../constants/mappings'
require_relative '../../constants/regexps'
require_relative 'models/match'
require_relative 'models/player'

module Scraper
	class Extractor
		def initialize(driver)
			@driver = driver
		end

		def extract(url)
			raise NotImplementedError
		end
	end

	class FixturesAndResultsExtractor < Extractor
		def extract(url)
			@driver.navigate.to(url)

			matches = extract_descriptions_and_results
			extract_venues_and_dates(matches)
			extract_teams_and_innings(matches)

			matches
		end

		private

		def extract_descriptions_and_results
			elements = @driver.find_elements(css: '.ds-text-tight-s.ds-font-medium.ds-text-typo')

			matches = []
			elements.each_slice(2) do |element_slice|
				description = element_slice[0].text
				result = element_slice[1].text

				match = if description =~ GROUP_MATCH_PATTERN
									MatchBuilder.new
										.type('Group')
										.group($1)
										.build
								elsif description =~ SUPER_EIGHT_MATCH_PATTERN
									MatchBuilder.new
										.type('Super Eight')
										.group($1)
										.build
								elsif description =~ SEMI_FINAL_MATCH_PATTERN
									MatchBuilder.new
										.type('Semi Final')
										.group(nil)
										.build
								else
									MatchBuilder.new
										.type('Final')
										.group(nil)
										.build
								end

				match.number = matches.length + 1

				if result =~ NORMAL_RESULT_PATTERN
					match.winner = translate_team_name($1)
					match.win_by = $2
				elsif result =~ SUPER_OVER_RESULT_PATTERN
					match.winner = translate_team_name($1)
					match.win_by = 'Super over'
				else
					match.winner = nil
					match.win_by = result
				end

				matches << match
			end

			matches
		end

		def extract_venues_and_dates(matches)
			venues_and_dates = @driver.find_elements(css: '.ds-text-tight-s.ds-font-regular.ds-truncate.ds-text-typo-mid3')

			i = 0
			venues_and_dates.each do |venue_and_date|
				if venue_and_date.text =~ VENUE_PATTERN
					matches[i].venue = $1
					matches[i].date = $2

					i += 1
				end
			end
		end

		def extract_teams_and_innings(matches)
			parent_elements = @driver.find_elements(css: '.ci-team-score').last(2 * matches.length)

			parent_elements.each_slice(2).with_index do |parent_element, idx|
				match = matches[idx]
				match.team_1 = translate_team_name(parent_element[0].find_elements(tag_name: 'div')[0].attribute('title'))
				match.team_2 = translate_team_name(parent_element[1].find_elements(tag_name: 'div')[0].attribute('title'))

				temp = parent_element[0].find_elements(tag_name: 'div')[1]
				match.inning_1 = temp&.find_element(tag_name: 'strong')&.text

				temp = parent_element[1].find_elements(tag_name: 'div')[1]
				match.inning_2 = temp&.find_element(tag_name: 'strong')&.text
			end
		end

		def translate_team_name(abbreviation)
			TEAM_NAMES[abbreviation] || abbreviation
		end
	end

	class PlayersExtractor < Extractor
		def extract(details_url, stats_url)
			squads = extract_squads(details_url)

			players = extract_player_details(details_url, squads)
			extract_player_stats(stats_url, players)

			players.values
		end

		private

		def extract_squads(url)
			@driver.navigate.to(url)

			squads = []
			clickables = @driver.find_elements(css: '.ds-inline-flex.ds-items-start.ds-leading-none', tag_name: 'a')
			clickables.each do |clickable|
				if clickable.text =~ SQUAD_PATTERN
					squads << clickable.text
				end
			end

			squads
		end

		def extract_player_details(url, squads)
			players = {}
			squads.each do |squad|
				team = squad.match(SQUAD_PATTERN)[1]
				wait = Selenium::WebDriver::Wait.new(timeout: 10)

				@driver.navigate.to(url)

				squad = @driver.find_element(link_text: squad)
				@driver.execute_script("arguments[0].scrollIntoView(true);", squad)
				wait.until { squad.displayed? && squad.enabled? }

				begin
					squad.click
				rescue Selenium::WebDriver::Error::ElementClickInterceptedError
					@driver.execute_script("arguments[0].click();", squad)
				end

				wait.until { @driver.find_element(css: '.ds-bg-fill-content-alternate.ds-flex.ds-justify-between.ds-items-center.ds-px-4.ds-py-3.ds-border-line.ds-border-y') }

				players_to_add = extract_names_and_statuses

				extract_roles(players_to_add)
				extract_ages(players_to_add)

				extract_batting_and_bowling_styles(players_to_add)

				players_to_add.each do |player|
					player.team = team
					players[player.name] = player
				end
			end

			players.freeze
		end

		def extract_player_stats(url, players)
			@driver.navigate.to(url)

			wait = Selenium::WebDriver::Wait.new(timeout: 10)

			squad_cnt = 0
			temps = @driver.find_elements(css: '.ds-border-line.ds-border.ds-border-none')
			temps.each do |temp|
				if temp.text.include?('Batting and bowling averages (by team)')
					temp.find_elements(tag_name: 'a').each do |link|
						squad_cnt += 1
					end
					break
				end
			end

			for i in 1..squad_cnt
				@driver.navigate.to(url)

				temps = @driver.find_elements(css: '.ds-border-line.ds-border.ds-border-none')
				temps.each do |temp|
					if temp.text.include?('Batting and bowling averages (by team)')
						link = temp.find_elements(tag_name: 'a')[i - 1]

						@driver.execute_script("arguments[0].scrollIntoView(true);", link)
						wait.until { link.displayed? && link.enabled? }

						begin
							link.click
						rescue Selenium::WebDriver::Error::ElementClickInterceptedError
							@driver.execute_script("arguments[0].click();", link)
						end

						wait.until { @driver.find_element(css: '.ds-text-title-s.ds-font-bold.ds-mb-2.ds-pl-4.ds-capitalize') }

						tables = @driver.find_elements(tag_name: 'tbody')
						if tables[0].find_elements(css: '.ds-bg-ui-fill-translucent', tag_name: 'tr').any?
							stats = tables[0].find_elements(tag_name: 'tr')
							stats.each do |player_stats|
								if player_stats.text =~ BATTING_STATS_PATTERN
									if PLAYER_NAMES.include?($1)
										players[PLAYER_NAMES[$1]].matches_played = $2
										players[PLAYER_NAMES[$1]].innings_batted = $3 == '-' ? nil : $3
										players[PLAYER_NAMES[$1]].notouts = $4 == '-' ? nil : $4
										players[PLAYER_NAMES[$1]].runs_scored = $5 == '-' ? nil : $5
										players[PLAYER_NAMES[$1]].balls_faced = $6
										players[PLAYER_NAMES[$1]].highest_score = $7 == '-' ? nil : $7
										players[PLAYER_NAMES[$1]].batting_average = $8
										players[PLAYER_NAMES[$1]].batting_strike_rate = $9
										players[PLAYER_NAMES[$1]].hundreds = $10 == '-' ? nil : $10
										players[PLAYER_NAMES[$1]].fifties = $11 == '-' ? nil : $11
										players[PLAYER_NAMES[$1]].ducks = $12 == '-' ? nil : $12
										players[PLAYER_NAMES[$1]].fours = $13
										players[PLAYER_NAMES[$1]].sixes = $14
									end
								end
							end
						end
						break
					end
				end
			end
		end

		def extract_names_and_statuses
			players = []

			names_and_statuses = @driver.find_elements(css: '.ds-flex.ds-flex-row.ds-items-center.ds-justify-between')
			names_and_statuses.each do |name_and_status|
				name_and_status = name_and_status.text.split.join(' ')

				player = 	if name_and_status =~ WITHDRAWN_PLAYER_PATTERN
										PlayerBuilder.new
											.name($1)
											.has_withdrawn(true)
											.is_captain(false)
											.is_vicecaptain(false)
											.build
									elsif name_and_status =~ CAPTAIN_PATTERN
										PlayerBuilder.new
											.name($1)
											.has_withdrawn(false)
											.is_captain(true)
											.is_vicecaptain(false)
											.build
									elsif name_and_status =~ VICE_CAPTAIN_PATTERN
										PlayerBuilder.new
											.name($1)
											.has_withdrawn(false)
											.is_captain(false)
											.is_vicecaptain(true)
											.build
									elsif name_and_status =~ PLAYER_PATTERN
										PlayerBuilder.new
											.name($1)
											.has_withdrawn(false)
											.is_captain(false)
											.is_vicecaptain(false)
											.build
									end

				players << player
			end

			players
		end

		def extract_roles(players)
			roles = @driver.find_elements(css: '.ds-text-tight-s.ds-font-regular.ds-mb-2.ds-mt-1')

			i = 0
			roles.each do |role|
				players[i].role = role.text
				i += 1
			end
		end

		def extract_ages(players)
			ages = @driver.find_elements(css: '.ds-flex.ds-items-center.ds-space-x-1')

			i = 0
			ages.each do |age|
				age = age.text.split.join(' ')
				if age =~ AGE_PATTERN
					players[i].age = $1
					i += 1
				end
			end
		end

		def extract_batting_and_bowling_styles(players)
			styles = @driver.find_elements(css: '.ds-flex.ds-items-start.ds-space-x-1')

			i = 0
			j = 0
			while i < styles.length
				if styles[i].text =~ BATTING_STYLE_PATTERN
					players[j].batting_style = $1

					if styles[i + 1].text =~ BOWLING_STYLE_PATTERN
						players[j].bowling_style = $1
						i += 2
					else
						players[j].bowling_style = nil
						i += 1
					end

					j += 1
				end
			end
		end
	end

	class RecordsExtractor < Extractor
		def extract(url)
			@driver.navigate.to(url)

			wait = Selenium::WebDriver::Wait.new(timeout: 10)

			temps = @driver.find_elements(css: '.ds-flex.ds-flex-col')
			temps.each do |temp|
				if temp.text.include?('Most runs')
					temp.find_elements(tag_name: 'a').each do |link|
						if link.text == 'Most runs'
							@driver.execute_script("arguments[0].scrollIntoView(true);", link)
							wait.until { link.displayed? && link.enabled? }

							begin
								link.click
							rescue Selenium::WebDriver::Error::ElementClickInterceptedError
								@driver.execute_script("arguments[0].click();", link)
							end

							wait.until { @driver.find_element(css: '.ds-text-title-s.ds-font-bold.ds-mb-2.ds-pl-4.ds-capitalize') }

							players = @driver.find_elements(css: '.ds-bg-ui-fill-translucent')
							players.each do |player|
								puts player.text, "\n"
							end
							break
						end
					end
					break
				end
			end
		end
	end
end
