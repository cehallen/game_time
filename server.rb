require 'pry'
require 'shotgun'
require 'sinatra'

         ###############
stats = [
  {
    home_team: "Patriots",
    away_team: "Broncos",
    home_score: 7,
    away_score: 3
  },
  {
    home_team: "Broncos",
    away_team: "Colts",
    home_score: 3,
    away_score: 0
  },
  {
    home_team: "Patriots",
    away_team: "Colts",
    home_score: 11,
    away_score: 7
  },
  {
    home_team: "Steelers",
    away_team: "Patriots",
    home_score: 7,
    away_score: 21
  }
]

         ############### this will create a template of teams with 0 wins and 0 losses
def build_teams(stats)
  teams_hash = {}
  stats.each do |game|
    if !teams_hash[game[:home_team]].is_a?(Hash)
      teams_hash[game[:home_team]] = {name: game[:home_team], w: 0, l: 0}
    end
    if
      !teams_hash[game[:away_team]].is_a?(Hash)
      teams_hash[game[:away_team]] = {name: game[:away_team], w: 0, l: 0}
    end
  end
  teams_hash
end
         ############### this will add wins and losses to teams_hash
def add_wins_losses(teams_hash, stats)
  stats.each do |game|
    if game[:home_score] > game[:away_score]
      # add win to home teams win's in teams_hash, add loss to away team
      teams_hash[game[:home_team]][:w] += 1
      teams_hash[game[:away_team]][:l] += 1
    else
      # add win to away team's wins in teams_hash, add loss to home team
      teams_hash[game[:away_team]][:w] += 1
      teams_hash[game[:home_team]][:l] += 1
    end
  end
  teams_hash_w_record = teams_hash
  # kinda confusing, want to make hash an array for returning to sort rankings below so it can be recursive
  teams_array_w_record = teams_hash_w_record.values
end

         ############### wrapper for sort method
def sort_rankings(teams_array_w_record)
  rec_sort_rankings(teams_array_w_record, [])
end
         ############### sort by wins
def rec_sort_rankings(unranked, ranked)
  if unranked.length <= 0
    return ranked
  end
  biggest = unranked.pop
  still_unranked = []
  unranked.each do |team|
    # these conditionals could be consolidated, but may be harder to read
    if biggest[:w] < team[:w]
      still_unranked.push(biggest)
      biggest = team
    elsif biggest[:w] == team[:w] && biggest[:l] > team[:l]
      still_unranked.push(biggest)
      biggest = team
    else # biggest[:w] > team[:w]
      still_unranked.push(team)
    end
  end
  ranked.push(biggest)
  rec_sort_rankings(still_unranked, ranked)
end
         ###############
teams_hash = build_teams(stats)
teams_array_w_record = add_wins_losses(teams_hash, stats)
sorted_rankings = sort_rankings(teams_array_w_record)
# p sorted_rankings

         ##############
get '/' do
  erb :index
end

get '/leaderboard' do
  @sorted_rankings = sorted_rankings
  erb :leaderboard
end



         ###############
set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'
