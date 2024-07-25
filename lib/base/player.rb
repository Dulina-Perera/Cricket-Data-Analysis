# lib/base/player.rb

class Player
	attr_accessor(:name, :team, :role, :is_captain, :is_vicecaptain, :age, :batting_style, :bowling_style)

	def initialize(name, team, role, captain, vicecaptain, age, batting_style, bowling_style)
		@name = name
		@team = team
		@role = role
		@is_captain = is_captain
		@is_vicecaptain = is_vicecaptain
		@age = age
		@batting_style = batting_style
		@bowling_style = bowling_style
	end

	def to_h
		{
			'Name' => @name,
			'Team' => @team,
			'Role' => @role,
			'Is_Captain' => @is_captain,
			'Is_ViceCaptain' => @is_vicecaptain,
			'Age' => @age,
			'Batting_Style' => @batting_style,
			'Bowling_Style' => @bowling_style
		}
	end
end

class PlayerBuilder
	def initialize
		@name = nil
		@team = nil
		@role = nil
		@is_captain = nil
		@is_vicecaptain = nil
		@age = nil
		@batting_style = nil
		@bowling_style = nil
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

	def build
		Player.new(@name, @team, @role, @is_captain, @is_vicecaptain, @age, @batting_style, @bowling_style)
	end
end
