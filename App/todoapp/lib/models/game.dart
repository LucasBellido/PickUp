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
