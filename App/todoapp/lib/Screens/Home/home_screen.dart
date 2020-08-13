import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:todoapp/components/create_game.dart';
import 'package:todoapp/components/explore.dart';
import 'package:todoapp/components/explore_content.dart';

import 'package:location/location.dart';
import 'package:todoapp/components/menu.dart';
import 'package:todoapp/components/search.dart';
import 'package:todoapp/components/search_form.dart';

import '../../helper.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/map";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController animationControllerExplore;
  AnimationController animationControllerSearch;
  AnimationController animationControllerMenu;
  CurvedAnimation curve;
  Animation<double> animation;
  Animation<double> animationW;
  Animation<double> animationR;

  /// get currentOffset percent
  get currentExplorePercent =>
      max(0.0, min(1.0, offsetExplore / (560.0 - 122.0)));
  get currentSearchPercent => max(0.0, min(1.0, offsetSearch / (347 - 68.0)));
  get currentMenuPercent => max(0.0, min(1.0, offsetMenu / 358));

  var offsetExplore = 0.0;
  var offsetSearch = 0.0;
  var offsetMenu = 0.0;

  bool isExploreOpen = false;
  bool isSearchOpen = false;
  bool isMenuOpen = false;

  /// search drag callback
  void onSearchHorizontalDragUpdate(details) {
    offsetSearch -= details.delta.dx;
    if (offsetSearch < 0) {
      offsetSearch = 0;
    } else if (offsetSearch > (347 - 68.0)) {
      offsetSearch = 347 - 68.0;
    }
    setState(() {});
  }

  /// explore drag callback
  void onExploreVerticalUpdate(details) {
    offsetExplore -= details.delta.dy;
    if (offsetExplore > 644) {
      offsetExplore = 644;
    } else if (offsetExplore < 0) {
      offsetExplore = 0;
    }
    setState(() {});
  }

  /// animate Explore
  ///
  /// if [open] is true , make Explore open
  /// else make Explore close
  void animateExplore(bool open) {
    animationControllerExplore = AnimationController(
        duration: Duration(
            milliseconds: 1 +
                (800 *
                        (isExploreOpen
                            ? currentExplorePercent
                            : (1 - currentExplorePercent)))
                    .toInt()),
        vsync: this);
    curve =
        CurvedAnimation(parent: animationControllerExplore, curve: Curves.ease);
    animation = Tween(begin: offsetExplore, end: open ? 760.0 - 122 : 0.0)
        .animate(curve)
          ..addListener(() {
            setState(() {
              offsetExplore = animation.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              isExploreOpen = open;
            }
          });
    animationControllerExplore.forward();
  }

  void animateSearch(bool open) {
    animationControllerSearch = AnimationController(
        duration: Duration(
            milliseconds: 1 +
                (800 *
                        (isSearchOpen
                            ? currentSearchPercent
                            : (1 - currentSearchPercent)))
                    .toInt()),
        vsync: this);
    curve =
        CurvedAnimation(parent: animationControllerSearch, curve: Curves.ease);
    animation = Tween(begin: offsetSearch, end: open ? 347.0 - 68.0 : 0.0)
        .animate(curve)
          ..addListener(() {
            setState(() {
              offsetSearch = animation.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              isSearchOpen = open;
            }
          });
    animationControllerSearch.forward();
  }

  void animateMenu(bool open) {
    animationControllerMenu =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    curve =
        CurvedAnimation(parent: animationControllerMenu, curve: Curves.ease);
    animation =
        Tween(begin: open ? 0.0 : 358.0, end: open ? 358.0 : 0.0).animate(curve)
          ..addListener(() {
            setState(() {
              offsetMenu = animation.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              isMenuOpen = open;
            }
          });
    animationControllerMenu.forward();
  }

  GoogleMapController _controller;
  bool isMapCreated = false;
  static final LatLng myLocation = LatLng(45.521563, -73.5673);

  @override
  void initState() {
    super.initState();
    _getLocationPermission();
  }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: myLocation,
    zoom: 14.4746,
  );

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("marker_1"),
          position: myLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          )),
    ].toSet();
  }

  void _getLocationPermission() async {
    var location = new Location();
    try {
      location.requestPermission();
    } on Exception catch (_) {
      print('There was a problem allowing location access');
    }
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/custom_map.json');
    _controller.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: _createMarker(),
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              setState(() {});
              _setMapStyle();
            },
          ),
          Explore(
            currentExplorePercent: currentExplorePercent,
            currentSearchPercent: currentSearchPercent,
            animateExplore: animateExplore,
            isExploreOpen: isExploreOpen,
            onVerticalDragUpdate: onExploreVerticalUpdate,
            onPanDown: () => animationControllerExplore?.stop(),
          ),
          offsetSearch != 0
              ? BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 10 * currentSearchPercent,
                      sigmaY: 10 * currentSearchPercent),
                  child: Container(
                    color: Colors.white.withOpacity(0.1 * currentSearchPercent),
                    width: screenWidth,
                    height: screenHeight,
                  ),
                )
              : const Padding(
                  padding: const EdgeInsets.all(0),
                ),
          ExploreContent(
            currentExplorePercent: currentExplorePercent,
          ),

          Search(
            currentSearchPercent: currentSearchPercent,
            currentExplorePercent: currentExplorePercent,
            isSearchOpen: isSearchOpen,
            animateSearch: animateSearch,
            onHorizontalDragUpdate: onSearchHorizontalDragUpdate,
            onPanDown: () => animationControllerSearch?.stop(),
          ),

          SearchForm(currentSearchPercent: currentSearchPercent),

          CreateGame(
            currentSearchPercent: currentSearchPercent,
            currentExplorePercent: currentExplorePercent,
            isSearchOpen: isSearchOpen,
            animateSearch: animateSearch,
            onHorizontalDragUpdate: onSearchHorizontalDragUpdate,
            onPanDown: () => animationControllerSearch?.stop(),
          ),

          //menu button
          Positioned(
            bottom: realH(150),
            left: realW(-71 * (currentExplorePercent + currentSearchPercent)),
            child: GestureDetector(
              onTap: () {
                animateMenu(true);
              },
              child: Opacity(
                opacity: 1 - (currentSearchPercent + currentExplorePercent),
                child: Container(
                  width: realW(71),
                  height: realH(71),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: realW(17)),
                  child: Icon(
                    Icons.menu,
                    size: realW(34),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(realW(36)),
                          topRight: Radius.circular(realW(36))),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            blurRadius: realW(36)),
                      ]),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: realH(250),
            left: realW(-71 * (currentExplorePercent + currentSearchPercent)),
            child: GestureDetector(
              onTap: () {
                //CENTER ON MY LOCATION
              },
              child: Opacity(
                opacity: 1 - (currentSearchPercent + currentExplorePercent),
                child: Container(
                  width: realW(71),
                  height: realH(71),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: realW(17)),
                  child: Icon(
                    Icons.my_location,
                    color: Color.fromRGBO(6, 193, 0, 1),
                    size: realW(34),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(realW(36)),
                          topRight: Radius.circular(realW(36))),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            blurRadius: realW(36)),
                      ]),
                ),
              ),
            ),
          ),

          //menu contents
          Menu(
              currentMenuPercent: currentMenuPercent, animateMenu: animateMenu),
        ],
      )),
    );
  }
}

/*
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
*/
