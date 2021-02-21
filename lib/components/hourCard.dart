import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourCard extends StatelessWidget {
  HourCard({@required this.temperature, @required this.backgrounColor, @required this.icon, @required this.date});

  final int temperature;
  final Color backgrounColor;
  final String icon;
  final DateTime date;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: backgrounColor,
        
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${DateFormat('d,MMM').format(date)}',
                  style: kWeatherDescp,
                ),
                Text(
                  '${DateFormat('EEE').format(date)}',
                  style: kWeekDay,
                ),
                Text(
                  '${date.hour}:00',
                  style: kWeatherDescp,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$temperature°',
                    style: kWeatherDescp,
                  ),
                  Text(
                    '$icon',
                    style: kWeatherDescp,
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}
