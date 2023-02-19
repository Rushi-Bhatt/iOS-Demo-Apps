#Tic-Tac-Toe Remote Coding Exercise

##How the game works
Tic-Tac-Toe is a 2-player game where each player alternates taking turns.
The goal is for one player to get three spaces in a row (either horizontally, vertically, or diagonally).
The game can be played by making a selection and then passing the phone to a friend to make another selection. 
We are only going to support this locally, so you don’t need to worry about server requests.

##ViewController
We’ll be adding improvements to this file as the interview progresses.
It contains some existing code to interface with. Most of this code represents view elements and constraints/layout.

##Models
###Marker
This is an enum that represents how a BoardSpace can be filled.
In our game, a marker can either be “x” or “o”. A corresponding image will match with the enum case.

###Player
This struct represents a person who takes an action by tapping a board space.
A player has a name (i.e. “Player 1”) and a marker (i.e. .o).

###GameResult
This enum represents the end state of a game.
The game can result in either a player winning (i.e. .winner(Player)) or a tie (i.e. .tie).
