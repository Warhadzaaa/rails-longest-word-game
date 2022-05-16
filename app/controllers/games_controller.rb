require 'open-uri'
require 'json'
require 'time'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @start_time = Time.now
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || '').upcase
    @start_time = Time.parse(params[:start_time])
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
    @end_time = Time.now
    @score_game = score_game(@word, @start_time, @end_time)
  end

  private

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def score_game(attempt, start_time, end_time)
    time_taken = end_time - start_time
    time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
  end
end
