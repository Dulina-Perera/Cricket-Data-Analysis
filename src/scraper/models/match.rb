# src/scraper/models/match.rb

module Scraper
	class Match
		attr_accessor(:number, :type, :group, :venue, :date, :match_refree, :umpire_1, :umpire_2, :tv_umpire, :reserve_umpire, :team_1, :team_2, :toss, :inning_1, :inning_2, :winner, :win_by, :player_of_the_match)

		def initialize(number, type, group, venue, date, match_refree, umpire_1, umpire_2, tv_umpire, reserve_umpire, team_1, team_2, toss, inning_1, inning_2, winner, win_by, player_of_the_match)
			@number = number
			@type = type
			@group = group
			@venue = venue
			@date = date
			@match_refree = match_refree
			@umpire_1 = umpire_1
			@umpire_2 = umpire_2
			@tv_umpire = tv_umpire
			@reserve_umpire = reserve_umpire
			@team_1 = team_1
			@team_2 = team_2
			@toss = toss
			@inning_1 = inning_1
			@inning_2 = inning_2
			@winner = winner
			@win_by = win_by
			@player_of_the_match = player_of_the_match
		end

		def to_h
			{
				'Match_Number' => @number,
				'Type' => @type,
				'Group' => @group,
				'Venue' => @venue,
				'Date' => @date,
				'Match_Refree' => @match_refree,
				'Umpire_1' => @umpire_1,
				'Umpire_2' => @umpire_2,
				'TV_Umpire' => @tv_umpire,
				'Reserve_Umpire' => @reserve_umpire,
				'Team_1' => @team_1,
				'Team_2' => @team_2,
				'Toss' => @toss,
				'Inning_1' => @inning_1,
				'Inning_2' => @inning_2,
				'Winner' => @winner,
				'Win_By' => @win_by,
				'Player_Of_The_Match' => @player_of_the_match
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
			@match_refree = nil
			@umpire_1 = nil
			@umpire_2 = nil
			@tv_umpire = nil
			@reserve_umpire = nil
			@team_1 = nil
			@team_2 = nil
			@toss = nil
			@inning_1 = nil
			@inning_2 = nil
			@winner = nil
			@win_by = nil
			@player_of_the_match = nil
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

		def match_refree(match_refree)
			@match_refree = match_refree
			self
		end

		def umpire_1(umpire_1)
			@umpire_1 = umpire_1
			self
		end

		def umpire_2(umpire_2)
			@umpire_2 = umpire_2
			self
		end

		def tv_umpire(tv_umpire)
			@tv_umpire = tv_umpire
			self
		end

		def reserve_umpire(reserve_umpire)
			@reserve_umpire = reserve_umpire
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

		def toss(toss)
			@toss = toss
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

		def player_of_the_match(player_of_the_match)
			@player_of_the_match = player_of_the_match
			self
		end

		def build
			Match.new(@number, @type, @group, @venue, @date, @match_refree, @umpire_1, @umpire_2, @tv_umpire, @reserve_umpire, @team_1, @team_2, @toss, @inning_1, @inning_2, @winner, @win_by, @player_of_the_match)
		end
	end
end
