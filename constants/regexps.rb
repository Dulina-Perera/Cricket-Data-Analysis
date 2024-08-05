# constants/regexps.rb

GROUP_MATCH_PATTERN = /^.*?Group\s*([a-zA-Z]).*$/
SUPER_EIGHT_MATCH_PATTERN = /^.*?Super Eights,\s*Group\s*(\d).*$/
SEMI_FINAL_MATCH_PATTERN = /^.*?Semi-Final.*$/
VENUE_PATTERN = /^.*?•\s*(.*?),\s*(.*?),\s*ICC.*$/
NORMAL_RESULT_PATTERN = /^(.*?)\s*won\s*by\s*(.*)$/
SUPER_OVER_RESULT_PATTERN = /^.*?\((.*?)\s*won.*$/

SQUAD_PATTERN = /^(.*?)\s*Squad$/
PLAYER_PATTERN = /^([a-zA-Z .'-]+?)(?:\s\†)?$/
CAPTAIN_PATTERN = /^([a-zA-Z .'-]+?)(?:\s\†)?\s\(c\)$/
VICE_CAPTAIN_PATTERN = /^([a-zA-Z .'-]+?)(?:\s\†)?\s\(vc\)$/
WITHDRAWN_PLAYER_PATTERN = /^([a-zA-Z .'-]+?)(?:\s\†)?\sWithdrawn$/
AGE_PATTERN = /^Age:\s(.*)$/
BATTING_STYLE_PATTERN = /^Batting:\s(.*)$/
BOWLING_STYLE_PATTERN = /^Bowling:\s(.*)$/

BATTING_STATS_PATTERN = /^([a-zA-Z .'-]+?)\s*\([A-Z]+\)\s*2024-2024\s*(\d)\s*(\d)\s*([\d-])\s*(\d+)\s*([\d*]+)\s*([\d.]+)\s*(\d+)\s*([\d.]+)\s*([\d-]+)\s*([\d-]+)\s*([\d-]+)\s*(\d+)\s*(\d+)$/
