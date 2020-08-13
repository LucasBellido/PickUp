import 'package:flutter/material.dart';
import 'package:todoapp/helper.dart';
import 'package:todoapp/models/game.dart';
import 'package:todoapp/models/global.dart';

class ExploreContent extends StatelessWidget {
  final double currentExplorePercent;

  const ExploreContent({Key key, this.currentExplorePercent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //size of screen

    if (currentExplorePercent != 0) {
      return Positioned(
        top: realH(
            standardHeight + (450 - standardHeight) * currentExplorePercent),
        width: screenWidth,
        child: Container(
          height: screenHeight,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Opacity(
                opacity: currentExplorePercent,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      width: size.width * 0.40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: FlatButton(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          color: Colors.white,
                          onPressed: () {},
                          child: Text(
                            "Public Games",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: size.width * 0.40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: FlatButton(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          color: Colors.white,
                          onPressed: () {},
                          child: Text(
                            "My Games",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /*Container(
                padding: EdgeInsets.only(top: 400, bottom: 20),
                alignment: Alignment.center,
                child: ListView(
                  padding: EdgeInsets.only(left: 20),
                  children: createGameCards(context),
                  scrollDirection: Axis.horizontal,
                ),
              )*/
            ],
          ),
        ),
      );
    } else {
      return const Padding(
        padding: const EdgeInsets.all(0),
      );
    }
  }

  List<Widget> createGameCards(BuildContext context) {
    List<Game> games = getGames();
    List<Widget> cards = [];
    for (Game game in games) {
      cards.add(buildGameCard(game, context));
    }
    return cards;
  }

  Widget buildGameCard(Game game, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: realW(22)),
      margin: EdgeInsets.only(right: 20),
      width: size.width * 0.7,
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
              borderRadius: BorderRadius.circular(30),
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
