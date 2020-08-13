import 'package:flutter/material.dart';
import 'user.dart';
import 'sports.dart';
import 'level.dart';

class Game {
  bool public;
  User gameCreator;
  int numberOfPlayers;
  Sports sport;
  String location;
  DateTime time;
  Level skillLevel;
  AssetImage locationImage;
  List<User> players;

  Game(
      this.public,
      this.gameCreator,
      this.numberOfPlayers,
      this.sport,
      this.location,
      this.time,
      this.skillLevel,
      this.locationImage,
      this.players);
}

List<Game> getGames() {
  List<Game> games = [];
  for (int i = 0; i < 10; i++) {
    List<User> players = getUsers();
    AssetImage courtPicture = new AssetImage("assets/images/tenniscourt.jpg");
    AssetImage profilepic = new AssetImage("assets/images/messi.png");

    User tim = User("tim98", "Tim", "Ber", "302 Pine St.", profilepic);
    Game myGame = new Game(true, tim, 2, Sports.Tennis, "Forbes Tennis Courts",
        new DateTime(2020, 8, 4, 13, 0), Level.Any, courtPicture, players);
    games.add(myGame);
  }
  return games;
}

List<Widget> getPlayers(Game game) {
  List<Widget> players = [];
  for (User player in game.players) {
    players.add(new Container(
      padding: EdgeInsets.only(right: 10),
      child: CircleAvatar(
        backgroundImage: player.profilePic,
      ),
    ));
  }
  return players;
}
