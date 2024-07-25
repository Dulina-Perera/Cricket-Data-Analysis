# config/constants.rb

GROUP_MATCH_PATTERN = /^.*?Group\s*([a-zA-Z]).*$/
SUPER_EIGHT_MATCH_PATTERN = /^.*?Super Eights,\s*Group\s*(\d).*$/
SEMI_FINAL_MATCH_PATTERN = /^.*?Semi-Final.*$/
VENUE_PATTERN = /^.*?•\s*(.*?),\s*(.*?),\s*ICC.*$/
NORMAL_RESULT_PATTERN = /^(.*?)\s*won\s*by\s*(.*)$/
SUPER_OVER_RESULT_PATTERN = /^.*?\((.*?)\s*won.*$/

SQUAD_PATTERN = /^(.*?)\s*Squad$/
WITHDRAWN_PLAYER_PATTERN = /^([a-zA-Z .'-]+?)(?:\s\†)?\sWithdrawn$/
PLAYER_PATTERN = /^([a-zA-Z .'-]+?)(?:\s\†)?$/
CAPTAIN_PATTERN = /^([a-zA-Z .'-]+?)(?:\s\†)?\s\(c\)$/
VICE_CAPTAIN_PATTERN = /^([a-zA-Z .'-]+?)(?:\s\†)?\s\(vc\)$/
