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
			:sixes,
			:innings_bowled,
			:overs_bowled,
			:maidens_earned,
			:runs_conceded,
			:wickets_taken,
			:best_bowling_figures,
			:bowling_average,
			:economy_rate,
			:bowling_strike_rate,
			:five_wickets_haul,
			:ten_wickets_haul,
			:catches_taken,
			:stumpings_made
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
			sixes,
			innings_bowled,
			overs_bowled,
			maidens_earned,
			runs_conceded,
			wickets_taken,
			best_bowling_figures,
			bowling_average,
			economy_rate,
			bowling_strike_rate,
			five_wickets_haul,
			ten_wickets_haul,
			catches_taken,
			stumpings_made
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
			@innings_bowled = innings_bowled
			@overs_bowled = overs_bowled
			@maidens_earned = maidens_earned
			@runs_conceded = runs_conceded
			@wickets_taken = wickets_taken
			@best_bowling_figures = best_bowling_figures
			@bowling_average = bowling_average
			@economy_rate = economy_rate
			@bowling_strike_rate = bowling_strike_rate
			@five_wickets_haul = five_wickets_haul
			@ten_wickets_haul = ten_wickets_haul
			@catches_taken = catches_taken
			@stumpings_made = stumpings_made
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
				'Sixes' => @sixes,
				'Innings_Bowled' => @innings_bowled,
				'Overs_Bowled' => @overs_bowled,
				'Maidens_Earned' => @maidens_earned,
				'Runs_Conceded' => @runs_conceded,
				'Wickets_Taken' => @wickets_taken,
				'Best_Bowling_Figures' => @best_bowling_figures,
				'Bowling_Average' => @bowling_average,
				'Economy_Rate' => @economy_rate,
				'Bowling_Strike_Rate' => @bowling_strike_rate,
				'Five_Wickets_Haul' => @five_wickets_haul,
				'Ten_Wickets_Haul' => @ten_wickets_haul,
				'Catches_Taken' => @catches_taken,
				'Stumpings_Made' => @stumpings_made
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
			@innings_bowled = nil
			@overs_bowled = nil
			@maidens_earned = nil
			@runs_conceded = nil
			@wickets_taken = nil
			@best_bowling_figures = nil
			@bowling_average = nil
			@economy_rate = nil
			@bowling_strike_rate = nil
			@five_wickets_haul = nil
			@ten_wickets_haul = nil
			@catches_taken = nil
			@stumpings_made = nil
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

		def innings_bowled(innings_bowled)
			@innings_bowled = innings_bowled
			self
		end

		def overs_bowled(overs_bowled)
			@overs_bowled = overs_bowled
			self
		end

		def maidens_earned(maidens_earned)
			@maidens_earned = maidens_earned
			self
		end

		def runs_conceded(runs_conceded)
			@runs_conceded = runs_conceded
			self
		end

		def wickets_taken(wickets_taken)
			@wickets_taken = wickets_taken
			self
		end

		def best_bowling_figures(best_bowling_figures)
			@best_bowling_figures = best_bowling_figures
			self
		end

		def bowling_average(bowling_average)
			@bowling_average = bowling_average
			self
		end

		def economy_rate(economy_rate)
			@economy_rate = economy_rate
			self
		end

		def bowling_strike_rate(bowling_strike_rate)
			@bowling_strike_rate = bowling_strike_rate
			self
		end

		def five_wickets_haul(five_wickets_haul)
			@five_wickets_haul = five_wickets_haul
			self
		end

		def ten_wickets_haul(ten_wickets_haul)
			@ten_wickets_haul = ten_wickets_haul
			self
		end

		def catches_taken(catches_taken)
			@catches_taken = catches_taken
			self
		end

		def stumpings_made(stumpings_made)
			@stumpings_made = stumpings_made
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
				@sixes,
				@innings_bowled,
				@overs_bowled,
				@maidens_earned,
				@runs_conceded,
				@wickets_taken,
				@best_bowling_figures,
				@bowling_average,
				@economy_rate,
				@bowling_strike_rate,
				@five_wickets_haul,
				@ten_wickets_haul,
				@catches_taken,
				@stumpings_made
			)
		end
	end
end
