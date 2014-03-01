require 'pry'
require 'shotgun'
require 'csv'
# require 'sinatra'




get '/' do
  erb :index
end

get '/leaderboard'
  @league_stats_array = league_stats_array
  erb :leaderboard
end
         ###############
def build_teams(stats)
  teams_hash = {}
  stats.each do |game|
    if !teams_hash[game[:home_team]].is_a?(String)
      teams_hash[game[:home_team]] = {w: 0, l: 0}
    end
    if
      !teams_hash[game[:away_team]].is_a?(String)
      teams_hash[game[:away_team]] = {w: 0, l: 0}
    end
  end
end
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
         ###############
set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'
