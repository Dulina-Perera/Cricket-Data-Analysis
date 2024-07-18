# lib/base/match.rb

# This struct represents a cricket match.
# It has the following attributes:
# - number: the match number
# - type: the type of match (e.g., Test, ODI, T20)
# - group: the group or stage of the match
# - venue: the venue where the match is played
# - team_1: the first team playing in the match
# - team_2: the second team playing in the match
# - inning_1: the first inning of the match
# - inning_2: the second inning of the match
# - winner: the winning team of the match
# - win_by: the method of winning (e.g., runs, wickets)
Match = Struct.new(
  :number,
  :type,
  :group,
  :venue,
  :team_1,
  :team_2,
  :inning_1,
  :inning_2,
  :winner,
  :win_by
)
