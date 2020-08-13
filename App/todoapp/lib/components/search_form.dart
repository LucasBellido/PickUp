import 'package:flutter/material.dart';
import 'package:todoapp/helper.dart';

class SearchForm extends StatelessWidget {
  final double currentSearchPercent;

  const SearchForm({Key key, this.currentSearchPercent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return currentSearchPercent != 0
        ? Positioned(
            top: realH(
                -(75.0 + 494.0) + (75 + 75.0 + 494.0) * currentSearchPercent),
            left: realW((standardWidth - 320) / 2),
            width: realW(320),
            height: realH(494),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Text('Search',
                        style: TextStyle(
                            fontSize: 20, color: Color.fromRGBO(6, 193, 0, 1))),
                    TextField(
                      decoration: const InputDecoration(helperText: "Sport"),
                      style: Theme.of(context).textTheme.headline1,
                    )
                  ],
                )
              ],
            ),
          )
        : const Padding(
            padding: const EdgeInsets.all(0),
          );
  }
}
