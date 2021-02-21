import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DailyCard extends StatelessWidget {
  DailyCard({@required this.temperatureMax, @required this.temperatureMin, @required this.backgroundColor, @required this.icon, @required this.date});

  final int temperatureMax;
  final int temperatureMin;
  final Color backgroundColor;
  final String icon;
  final DateTime date;

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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${DateFormat('d MMM').format(date)}',
                style: kWeatherDescp,
              ),

              Text(
                '${DateFormat('EEEE').format(date)}',
                style: kWeekDay,
              ),
            ],
          ),
          Text(
            '$temperatureMax° / $temperatureMin°',
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
