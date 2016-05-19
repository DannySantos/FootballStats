require 'pry'
require 'date'

class Match
  require 'csv'
  
  @@match_count = 0
  
  attr_accessor :date, :team_1, :team_2, :ft_home, :ft_away, :ht_home, :ht_away
  
  def initialize(date, team_1, team_2, ft_home, ft_away, ht_home, ht_away)
    @date = date
    @team_1 = team_1
    @team_2 = team_2
    @ft_home = ft_home
    @ft_away = ft_away
    @ht_home = ht_home
    @ht_away = ht_away
    @@match_count += 1
  end
  
  def self.match_count
    @@match_count
  end
  
  def self.read_data
    match_data = CSV.read("pl_2013_2014.csv")
    match_data.shift
    results = []
    
    
    match_data.each do |match|
      ft = match[3].split("-")
      ht = match[4].split("-")
      results << Match.new(Date.parse(match[0]), 
        match[1], 
        match[2], 
        ft.first == "C"? nil : ft.first.to_i, 
        ft.last == "C"? nil : ft.last.to_i,
        ht.first == "C"? nil : ht.first.to_i,
        ht.last == "C"? nil : ht.last.to_i)
    end
    
    results
  end
end

matches = Match.read_data

def all_team_results(team, data) ####### %%%TODO Make data auto
  puts "All #{team} results:"
  arsenal_matches = data.select {|match| match.team_1 == team || match.team_2 == team }
  arsenal_matches.each do |match| 
    puts "Home: #{match.team_1}"
    puts "Away: #{match.team_2}"
    puts "Score: #{match.ft_home}-#{match.ft_away}"
    puts "========================="
  end
end

def all_draws(data)
  puts "All draw results:"
  draws = data.select {|match| match.ft_home == match.ft_away}
  draws.each do |match| 
    puts "Home: #{match.team_1}"
    puts "Away: #{match.team_2}"
    puts "Score: #{match.ft_home}-#{match.ft_away}"
    puts "========================="
  end
end

def two_teams(team_1, team_2, data)
  puts "All #{team_1}-#{team_2} results:"
  scores = data.select {|match| (match.team_1 == team_1 || match.team_2 == team_1) && (match.team_1 == team_2 || match.team_2 == team_2)}
  scores.each do |match| 
    puts ""
    puts "Home: #{match.team_1}"
    puts "Away: #{match.team_2}"
    puts "Score: #{match.ft_home}-#{match.ft_away}"
    puts "========================="
  end
end

def show_home_goals_average(matches)
  home = matches.map(&:ft_home).inject(0) {|results, score| results += score}
  home.to_f / matches.count
end

def show_away_goals_average(matches)
  away = matches.map(&:ft_away).inject(0) {|results, score| results += score}
  away.to_f / matches.count
end



binding.pry















