require 'rspec'
require 'pry'

class TicTacToe
  attr_accessor :board, :player
  def initialize
    @board = [["", "", ""],["", "", ""],["", "", ""]]
    @player = "x"
  end

  def move(x, y)
    return if x > 2 || x < 0
    return if y > 2 || y < 0
    return unless board[x][y].empty?
    board[x][y] = player
    switch_player
  end

  def switch_player
    @player = @player == "x" ? "y" : "x"
  end

  def horizontal_win?
    board.any? {|row| row.all? {|move| move == @player} }
  end

  def vertical_win?
    board[0].each_with_index do |value, i|
       z = (value == @player && board[1][i] == @player && board[2][i] == @player)
       return z if z == true
    end
  end

  def diagonal_win?
    return true if board[0][0] == @player && board[1][1] == @player && board[2][2]
    return true if board[0][2] == @player && board[1][1] == @player && board[2][0]
  end

  def tie?
    return true if board.all? {|row| row.all? {|spot| !spot.empty?}}
  end
end

describe TicTacToe do

  before(:each) do
    @game = TicTacToe.new
  end

 it "initializes a game board" do
   expect(@game.board).to eq([["", "", ""],["", "", ""],["", "", ""]])
 end

 it "can mark a spot on the board" do
   @game.move(0, 0)
   expect(@game.board).to eq([["x", "", ""],["", "", ""],["", "", ""]])
 end

 it "can mark another spot on the board" do
   @game.move(1, 2)
   expect(@game.board).to eq([["", "", ""],["", "", "x"],["", "", ""]])
 end

 it "starts out as an x player" do
   expect(@game.player).to eq("x")
 end

 it "can switch the player after a move" do
   @game.move(0, 0)
   expect(@game.player).to eq("y")
 end

 it "can keeps track of the correct player after a couple moves" do
   @game.move(0, 0)
   @game.move(1, 0)
   expect(@game.player).to eq("x")
   expect(@game.board).to eq([["x", "", ""],["y", "", ""],["", "", ""]])
 end

 it "doesn't allow a place to move to a spot already filled" do
   @game.move(0, 0)
   @game.move(0, 0)
   expect(@game.player).to eq("y")
 end

 it "must be a move within the board" do
   @game.move(3, 0)
   expect(@game.board).to eq([["", "", ""],["", "", ""],["", "", ""]])
 end

 it "allows a player to win horizontal" do
   @game.board = [["x", "x", "x"],["y", "y", ""],["", "", ""]]
   expect(@game.horizontal_win?).to eq(true)
 end

 it "allows a player to win vertically" do
   @game.board = [["x", "x", "x"],["x", "y", ""],["x", "", ""]]
   expect(@game.vertical_win?).to eq(true)
 end

 it "allows a player to win vertically another way" do
   @game.board = [["y", "x", "x"],["y", "x", ""],["x", "x", ""]]
   expect(@game.vertical_win?).to eq(true)
 end

 it "allows a player to win diagonally" do
   @game.board = [["y", "x", "x"],["y", "y", ""],["x", "x", "y"]]
   @game.player = "y"
   expect(@game.diagonal_win?).to eq(true)
 end

 it "can be a tie" do
   @game.board = [["y", "x", "x"],["x", "y", "y"],["x", "x", "y"]]
   expect(@game.tie?).to eq(true)
 end
end
