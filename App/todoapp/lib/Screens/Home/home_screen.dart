import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:todoapp/components/rounded_button.dart';
import 'dart:async';

import 'package:todoapp/models/game.dart';
import 'package:todoapp/models/global.dart';
import 'package:todoapp/models/level.dart';
import 'package:todoapp/models/sports.dart';
import 'package:todoapp/models/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -73.5673);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            myLocationButtonEnabled: false,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 475),
            child: Center(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 35),
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20.0,
                    ),
                  ],
                  color: Colors.white,
                ),
                height: 50,
                width: 300,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: "What are you looking for?",
                      hintStyle: TextStyle(fontFamily: 'Gotham', fontSize: 15),
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 400, bottom: 20),
            alignment: Alignment.center,
            child: ListView(
              padding: EdgeInsets.only(left: 20),
              children: createGameCards(),
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      )),
    );
  }

  List<Game> getGames() {
    List<Game> games = [];
    for (int i = 0; i < 10; i++) {
      List<User> players = getUsers();
      AssetImage courtPicture = new AssetImage("assets/images/tenniscourt.jpg");
      AssetImage profilepic = new AssetImage("assets/images/messi.png");

      User tim = User("tim98", "Tim", "Ber", "302 Pine St.", profilepic);
      Game myGame = new Game(
          true,
          tim,
          2,
          Sports.Tennis,
          "Forbes Tennis Courts",
          new DateTime(2020, 8, 4, 13, 0),
          Level.Any,
          courtPicture,
          players);
      games.add(myGame);
    }
    return games;
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

  List<Widget> createGameCards() {
    List<Game> games = getGames();
    List<Widget> cards = [];
    for (Game game in games) {
      cards.add(gameCard(game));
    }
    return cards;
  }

  Widget gameCard(Game game) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 20),
      width: size.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: Colors.grey,
            blurRadius: 20.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: CircleAvatar(
                  backgroundImage: game.locationImage,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    game.gameCreator.firstName +
                        "'s " +
                        game.sport.toString().split(".")[1] +
                        " Game",
                    style: techCardTitleStyle,
                  ),
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Text(
                  "Time:  ",
                  style: techCardSubTitleStyle,
                ),
                Text(game.time.toLocal().toString(),
                    style: statusAvailableStyle)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Text(
                  "Location:  ",
                  style: techCardSubTitleStyle,
                ),
                Text(game.location, style: techCardSubTitleStyle)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Players: " +
                          game.players.length.toString() +
                          '/' +
                          game.numberOfPlayers.toString(),
                      style: techCardSubTitleStyle,
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(children: getPlayers(game))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                color: Colors.green,
                onPressed: () {},
                child: Text(
                  "+ JOIN",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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
