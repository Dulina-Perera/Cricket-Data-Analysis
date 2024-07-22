# lib/base/extractor.rb

module Base
	class Extractor
		def extract_descriptions_and_results(driver)
			elements = driver.find_elements(css: '.ds-text-tight-s.ds-font-medium.ds-text-typo')

			types = []
			groups = []
			winners = []
			win_by = []

			elements.each_slice(2) do |element_slice|
				description = element_slice[0].text
				result = element_slice[1].text

				if description =~ GROUP_MATCH_PATTERN
					groups << $1
					types << 'Group'
				elsif description =~ SUPER_EIGHT_MATCH_PATTERN
					groups << $1
					types << 'Super Eights'
				elsif description =~ SEMI_FINAL_MATCH_PATTERN
					groups << nil
					types << 'Semi-Final'
				else
					groups << nil
					types << 'Final'
				end

				if result =~ NORMAL_RESULT_PATTERN
					winners << $1
					win_by << $2
				elsif result =~ SUPER_OVER_RESULT_PATTERN
					winners << $1
					win_by << 'Super over'
				else
					winners << nil
					win_by << result
				end
			end

			[types, groups, winners, win_by]
		end

		def extract_venues_and_dates(driver)
			elements = driver.find_elements(css: '.ds-text-tight-s.ds-font-regular.ds-truncate.ds-text-typo-mid3')

			venues = []
			dates = []
			elements.each do |element|
				if element.text =~ VENUE_PATTERN
					venues << $1
					dates << $2
				end
			end

			[venues, dates]
		end

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
