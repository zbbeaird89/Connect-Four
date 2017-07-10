require_relative "../lib/connect_four.rb"

puts "Welcome to Connect Four!"

puts "What is First Player's name?"

player1 = ConnectFour::Player.new(:name => gets.chomp, :symbol => "\u2776".encode("utf-8"))

puts "What is Second Player's name?"

player2 = ConnectFour::Player.new(:name => gets.chomp, :symbol => "\u2777".encode("utf-8"))

players = [player1, player2]

ConnectFour::Game.new(ConnectFour::Board.new, players).play


