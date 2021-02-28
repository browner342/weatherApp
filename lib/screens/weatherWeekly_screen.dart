import 'package:clima/components/dailyCard.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../services/dataKeeper.dart';
import '../services/weather.dart';

class WeatherWeeklyScreen extends StatefulWidget {
  WeatherWeeklyScreen({this.dataKeeper});

  final DataKeeper dataKeeper;

  @override
  _WeatherWeeklyScreenState createState() => _WeatherWeeklyScreenState();
}

class _WeatherWeeklyScreenState extends State<WeatherWeeklyScreen>{
  WeatherModel weatherModel = WeatherModel();
  DataKeeper dataKeeper = DataKeeper();

  List<Widget> dailyCards() {
    List<Widget> cards = [];

    for(var i = 0; i < kCardWeeklyAmount; i++){
      var item = Expanded(
        child: DailyCard(
          temperatureMax: dataKeeper.tempMaxDaily[i],
          temperatureMin: dataKeeper.tempMinDaily[i],
          backgroundColor: dataKeeper.colorDaily[i],
          icon: dataKeeper.iconDaily[i],
          date: dataKeeper.dateDaily[i],
        ),
      );
      cards.add(item);
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    dataKeeper = widget.dataKeeper;
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
                    child: Column(
                      children: dailyCards(),
                    ),
                  ),
                ]
            )
        )
    );
  }
}

