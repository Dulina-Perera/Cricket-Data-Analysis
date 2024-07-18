# lib/base/extractor.rb

module Base
	# This class is responsible for extracting data from web pages.
	class Extractor
		# Extracts descriptions and results from the web page using the provided driver.
		#
		# @param driver [WebDriver] The driver used to interact with the web page.
		# @return [Array<WebElement>] An array of web elements representing the descriptions and results.
		def extract_descriptions_and_results(driver)
			driver.find_elements(css: '.ds-text-tight-s.ds-font-medium.ds-text-typo')
		end

		# Extracts venues from the web page using the provided driver.
		#
		# @param driver [WebDriver] The driver used to interact with the web page.
		# @return [Array<WebElement>] An array of web elements representing the venues.
		def extract_venues(driver)
			driver.find_elements(css: '.ds-text-tight-s.ds-font-regular.ds-truncate.ds-text-typo-mid3')
		end

		# Parses the descriptions and results to create an array of Match objects.
		#
		# @param descriptions_and_results [Array<WebElement>] An array of web elements representing the descriptions and results.
		# @return [Array<Match>] An array of Match objects.
		def parse_matches(descriptions_and_results)
			matches = []
			match_number = 1

			descriptions_and_results.each_slice(2) do |description_and_result|
				description = description_and_result[0].text
				result = description_and_result[1].text

				match = Match.new(match_number, nil, nil, nil, nil, nil, nil, nil, nil, nil)

				if description =~ GROUP_MATCH_PATTERN
					match.group = $1
					match.type = 'Group'
				elsif description =~ SUPER_EIGHT_MATCH_PATTERN
					match.group = $1
					match.type = 'Super Eights'
				elsif description =~ SEMI_FINAL_MATCH_PATTERN
					match.type = 'Semi-Final'
				else
					match.type = 'Final'
				end

				if result =~ RESULT_PATTERN
					match.winner = $1
					match.win_by = $2
				end

				matches << match
				match_number += 1
			end

			matches
		end

		# Extracts venues for each match from the web page and assigns them to the corresponding Match objects.
		#
		# @param matches [Array<Match>] An array of Match objects.
		# @param venues [Array<WebElement>] An array of web elements representing the venues.
		def extract_venues_for_matches(matches, venues)
			matches.each_with_index do |match, i|
				if venues[i].text =~ VENUE_PATTERN
					match.venue = $1
				end
			end
		end

		# Extracts teams and innings for each match from the web page and assigns them to the corresponding Match objects.
		#
		# @param driver [WebDriver] The driver used to interact with the web page.
		# @param matches [Array<Match>] An array of Match objects.
		def extract_teams_and_innings(driver, matches)
			parent_elements = driver.find_elements(css: '.ci-team-score').last(2 * matches.length)

			parent_elements.each_slice(2).with_index do |parent_element, idx|
				match = matches[idx]
				match.team_1 = parent_element[0].find_elements(tag_name: 'div')[0].attribute('title')
				match.team_2 = parent_element[1].find_elements(tag_name: 'div')[0].attribute('title')

				temp = parent_element[0].find_elements(tag_name: 'div')[1]
				match.inning_1 = temp&.find_element(tag_name: 'strong')&.text

				temp = parent_element[1].find_elements(tag_name: 'div')[1]
				match.inning_2 = temp&.find_element(tag_name: 'strong')&.text
			end
		end
	end
end
