import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HourCard extends StatelessWidget {
  HourCard({@required this.temperature, @required this.backgrounColor, @required this.icon, @required this.hour});

  final int temperature;
  final Color backgrounColor;
  final String icon;
  final int hour;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: backgrounColor,
        
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '$hour:00',
            style: kWeatherDescp,
          ),
          Text(
            '$temperature°',
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
