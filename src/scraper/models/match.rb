# src/scraper/models/match.rb

module Scraper
	class Match
		attr_accessor(:number, :type, :group, :venue, :date, :team_1, :team_2, :inning_1, :inning_2, :winner, :win_by)

		def initialize(number, type, group, venue, date, team_1, team_2, inning_1, inning_2, winner, win_by)
			@number = number
			@type = type
			@group = group
			@venue = venue
			@date = date
			@team_1 = team_1
			@team_2 = team_2
			@inning_1 = inning_1
			@inning_2 = inning_2
			@winner = winner
			@win_by = win_by
		end

		def to_h
			{
				'Match_Number' => @number,
				'Type' => @type,
				'Group' => @group,
				'Venue' => @venue,
				'Date' => @date,
				'Team_1' => @team_1,
				'Team_2' => @team_2,
				'Inning_1' => @inning_1,
				'Inning_2' => @inning_2,
				'Winner' => @winner,
				'Win_By' => @win_by
			}
		end
	end

	class MatchBuilder
		def initialize
			@number = nil
			@type = nil
			@group = nil
			@venue = nil
			@date = nil
			@team_1 = nil
			@team_2 = nil
			@inning_1 = nil
			@inning_2 = nil
			@winner = nil
			@win_by = nil
		end

		def number(number)
			@number = number
			self
		end

		def type(type)
			@type = type
			self
		end

		def group(group)
			@group = group
			self
		end

		def venue(venue)
			@venue = venue
			self
		end

		def date(date)
			@date = date
			self
		end

		def team_1(team_1)
			@team_1 = team_1
			self
		end

		def team_2(team_2)
			@team_2 = team_2
			self
		end

		def inning_1(inning_1)
			@inning_1 = inning_1
			self
		end

		def inning_2(inning_2)
			@inning_2 = inning_2
			self
		end

		def winner(winner)
			@winner = winner
			self
		end

		def win_by(win_by)
			@win_by = win_by
			self
		end

		def build
			Match.new(@number, @type, @group, @venue, @date, @team_1, @team_2, @inning_1, @inning_2, @winner, @win_by)
		end
	end
end
