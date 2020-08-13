import 'package:flutter/material.dart';
import 'package:todoapp/helper.dart';

/// Drawer Menu
class Menu extends StatelessWidget {
  final menuItems = [
    'Friends',
    'Manage Notifications',
    'Connect with Facebook',
    'Donate',
    'Help',
    'Settings'
  ];

  final num currentMenuPercent;
  final Function(bool) animateMenu;

  Menu({Key key, this.currentMenuPercent, this.animateMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //size of screen

    return currentMenuPercent != 0
        ? Positioned(
            left: realW(-358 + 358 * currentMenuPercent),
            width: realW(358),
            height: screenHeight,
            child: Opacity(
              opacity: currentMenuPercent,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(realW(50))),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.16),
                        blurRadius: realW(20)),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowGlow();
                      },
                      child: CustomScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        slivers: <Widget>[
                          SliverToBoxAdapter(
                            child: Container(
                              height: realH(236),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(6, 193, 0, 0.9),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(realW(50))),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: realW(30),
                                    bottom: realH(27),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('assets/images/messi.png'),
                                    ),
                                  ),
                                  Positioned(
                                    left: realW(135),
                                    top: realH(110),
                                    child: DefaultTextStyle(
                                      style: TextStyle(color: Colors.white),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Lionel Messi",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: realW(18)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: realH(11.0)),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text.rich(
                                                TextSpan(
                                                  text: "leomessi10",
                                                  style: TextStyle(
                                                    fontSize: realW(16),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                "Montreal, QC",
                                                style: TextStyle(
                                                    fontSize: realW(14)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding: EdgeInsets.only(
                              top: realH(34),
                              bottom: realH(50),
                              //right: realW(37)
                            ),
                            sliver: SliverFixedExtentList(
                              itemExtent: realH(56),
                              delegate: new SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Container(
                                    width: size.width * 0.6,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: realW(20)),
                                    child: FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                          menuItems[index],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: realW(20)),
                                        )));
                              }, childCount: menuItems.length),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // close button
                    Positioned(
                      bottom: realH(53),
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          animateMenu(false);
                        },
                        child: Container(
                          width: realW(71),
                          height: realH(71),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: realW(17)),
                          child: Icon(
                            Icons.close,
                            color: Color(0xFFE96977),
                            size: realW(34),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFFB5E74).withOpacity(0.4),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(realW(36)),
                                topLeft: Radius.circular(realW(36))),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : const Padding(padding: EdgeInsets.all(0));
  }
}
