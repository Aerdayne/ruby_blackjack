# CLI Single Player Blackjack

A simple single player CLI Blackjack game.

The game is a single player version of Blackjack written in Ruby. The rules are severely simplified and only one standart 52-card deck is used. Wager amount can not be altered. Player can only stand, hit and flip their cards.

Game logic is decoupled from the user interface, making it possible to switch from CLI to some other form of user interaction.

A miniscule test suite has also been written using TestUnit, covering several delicate hand value calculation cases.

## Demo
<img src="./img/demo.gif?raw=true"/>

## Installation
* Install Ruby 2.6.3 using [RVM](https://rvm.io/)
```bash
rvm install ruby-2.6.3
rvm use ruby-2.6.3
```
* Clone the repository
* Switch to the app directory and run the following command:
```bash
ruby bin/blackjack
```
* To run the tests use:
```bash
ruby tests/test.rb
```