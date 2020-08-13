import 'package:flutter/cupertino.dart';

class User {
  String userName;
  String firstName;
  String lastName;
  String address;
  AssetImage profilePic;

  User(this.userName, this.firstName, this.lastName, this.address,
      this.profilePic);
}

List<User> getUsers() {
  List<User> players = [];
  AssetImage profilepic = new AssetImage("assets/images/messi.png");
  User tim = User("tim98", "Tim", "Ber", "302 Pine St.", profilepic);
  User lucas =
      User("lucas98", "Lucas", "Bellido", "1200 SaintAlexander", profilepic);

  players.add(tim);
  players.add(lucas);
  return players;
}
