import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/dataKeeper.dart';

class DailyCard extends StatelessWidget {
  DailyCard({@required this.temperatureMax, @required this.temperatureMin, @required this.backgroundColor, @required this.icon, @required this.hour});

  int temperatureMax;
  int temperatureMin;
  Color backgroundColor;
  String icon;
  int hour;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: backgroundColor,

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '$hour:00',
            style: kWeatherDescp,
          ),
          Text(
            '$temperatureMax° - $temperatureMin°',
            style: kWeatherDescp,
          ),
          Text(
            '$icon',
            style: kWeatherDescp,
          ),
        ],
      ),
    );
  }
}
