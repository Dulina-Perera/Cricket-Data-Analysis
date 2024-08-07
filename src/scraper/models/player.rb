# src/scraper/models/player.rb

module Scraper
	class Player
		attr_accessor(
			:name,
			:team,
			:role,
			:has_withdrawn,
			:is_captain,
			:is_vicecaptain,
			:age,
			:batting_style,
			:bowling_style,
			:matches_played,
			:innings_batted,
			:notouts,
			:runs_scored,
			:balls_faced,
			:highest_score,
			:batting_average,
			:batting_strike_rate,
			:hundreds,
			:fifties,
			:ducks,
			:fours,
			:sixes
		)

		def initialize(
			name,
			team,
			role,
			has_withdrawn,
			is_captain,
			is_vicecaptain,
			age,
			batting_style,
			bowling_style,
			matches_played,
			innings_batted,
			notouts,
			runs_scored,
			balls_faced,
			highest_score,
			batting_average,
			batting_strike_rate,
			hundreds,
			fifties,
			ducks,
			fours,
			sixes
		)
			@name = name
			@team = team
			@role = role
			@has_withdrawn = has_withdrawn
			@is_captain = is_captain
			@is_vicecaptain = is_vicecaptain
			@age = age
			@batting_style = batting_style
			@bowling_style = bowling_style
			@matches_played = matches_played
			@innings_batted = innings_batted
			@notouts = notouts
			@runs_scored = runs_scored
			@balls_faced = balls_faced
			@highest_score = highest_score
			@batting_average = batting_average
			@batting_strike_rate = batting_strike_rate
			@hundreds = hundreds
			@fifties = fifties
			@ducks = ducks
			@fours = fours
			@sixes = sixes
		end

		def to_h
			{
				'Name' => @name,
				'Team' => @team,
				'Role' => @role,
				'has_withdrawn' => @has_withdrawn,
				'Is_Captain' => @is_captain,
				'Is_ViceCaptain' => @is_vicecaptain,
				'Age' => @age,
				'Batting_Style' => @batting_style,
				'Bowling_Style' => @bowling_style,
				'Matches_Played' => @matches_played,
				'Innings_Batted' => @innings_batted,
				'Notouts' => @notouts,
				'Runs_Scored' => @runs_scored,
				'Balls_Faced' => @balls_faced,
				'Highest_Score' => @highest_score,
				'Batting_Average' => @batting_average,
				'Batting_Strike_Rate' => @batting_strike_rate,
				'Hundreds' => @hundreds,
				'Fifties' => @fifties,
				'Ducks' => @ducks,
				'Fours' => @fours,
				'Sixes' => @sixes
			}
		end
	end

	class PlayerBuilder
		def initialize
			@name = nil
			@team = nil
			@role = nil
			@has_withdrawn = nil
			@is_captain = nil
			@is_vicecaptain = nil
			@age = nil
			@batting_style = nil
			@bowling_style = nil
			@matches_played = nil
			@innings_batted = nil
			@notouts = nil
			@runs_scored = nil
			@balls_faced = nil
			@highest_score = nil
			@batting_average = nil
			@batting_strike_rate = nil
			@hundreds = nil
			@fifties = nil
			@ducks = nil
			@fours = nil
			@sixes = nil
		end

		def name(name)
			@name = name
			self
		end

		def team(team)
			@team = team
			self
		end

		def role(role)
			@role = role
			self
		end

		def has_withdrawn(has_withdrawn)
			@has_withdrawn = has_withdrawn
			self
		end

		def is_captain(is_captain)
			@is_captain = is_captain
			self
		end

		def is_vicecaptain(is_vicecaptain)
			@is_vicecaptain = is_vicecaptain
			self
		end

		def age(age)
			@age = age
			self
		end

		def batting_style(batting_style)
			@batting_style = batting_style
			self
		end

		def bowling_style(bowling_style)
			@bowling_style = bowling_style
			self
		end

		def matches_played(matches_played)
			@matches_played = matches_played
			self
		end

		def innings_batted(innings_batted)
			@innings_batted = innings_batted
			self
		end

		def notouts(notouts)
			@notouts = notouts
			self
		end

		def runs_scored(runs_scored)
			@runs_scored = runs_scored
			self
		end

		def balls_faced(balls_faced)
			@balls_faced = balls_faced
			self
		end

		def highest_score(highest_score)
			@highest_score = highest_score
			self
		end

		def batting_average(batting_average)
			@batting_average = batting_average
			self
		end

		def batting_strike_rate(batting_strike_rate)
			@batting_strike_rate = batting_strike_rate
			self
		end

		def hundreds(hundreds)
			@hundreds = hundreds
			self
		end

		def fifties(fifties)
			@fifties = fifties
			self
		end

		def ducks(ducks)
			@ducks = ducks
			self
		end

		def fours(fours)
			@fours = fours
			self
		end

		def sixes(sixes)
			@sixes = sixes
			self
		end

		def build
			Player.new(
				@name,
				@team,
				@role,
				@has_withdrawn,
				@is_captain,
				@is_vicecaptain,
				@age,
				@batting_style,
				@bowling_style,
				@matches_played,
				@innings_batted,
				@notouts,
				@runs_scored,
				@balls_faced,
				@highest_score,
				@batting_average,
				@batting_strike_rate,
				@hundreds,
				@fifties,
				@ducks,
				@fours,
				@sixes
			)
		end
	end
end
