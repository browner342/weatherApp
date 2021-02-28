import 'package:clima/components/hourCard.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../services/dataKeeper.dart';


class WeatherHourlyScreen extends StatelessWidget {
  WeatherHourlyScreen({this.dataKeeper});

  final DataKeeper dataKeeper;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 50.0,
                    ),
                  ),
                ),
                Text(
                  '${dataKeeper.cityName}',
                  style: kCityNameTextStyle,
                ),
              ],
            ),
            Expanded(
              // child: Column(
              //   children: hourlyCards(),
              // ),
              child: CustomScrollView(
                slivers: <Widget> [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context, int i){
                      return Container(
                        height: 80,
                        child: HourCard(
                          temperature: dataKeeper.tempHourly[i],
                          backgrounColor: dataKeeper.colorHourly[i],
                          icon: dataKeeper.iconHourly[i],
                          date: dataKeeper.dateHourly[i],
                        ),
                      );
                    },
                    childCount: kCardHourlyAmount,
                  ),)
                ],
              ),
            ),
          ]
        )
      )
    );
  }
}

