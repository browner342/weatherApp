import 'package:clima/components/hourCard.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../services/dataKeeper.dart';
import '../services/weather.dart';

class WeatherHourlyScreen extends StatefulWidget {
  WeatherHourlyScreen({this.dataKeeper});

  DataKeeper dataKeeper = DataKeeper();

  @override
  _WeatherHourlyScreenState createState() => _WeatherHourlyScreenState();
}

class _WeatherHourlyScreenState extends State<WeatherHourlyScreen>{
  WeatherModel weatherModel = WeatherModel();
  DataKeeper dataKeeper = DataKeeper();

  List<Widget> hourlyCards(){
    List<Widget> cards = [];

    for(var i = 0; i < kCardAmount; i++){
      var item = Expanded(
        child: HourCard(
          temperature: dataKeeper.tempHourly[i],
          backgrounColor: dataKeeper.colorHourly[i],
          icon: dataKeeper.iconHourly[i],
          hour: dataKeeper.hourHourly[i],
        ),
      );
      cards.add(item);
    }

    return cards;
  }


  @override
  void initState() {
    updateUI();
    super.initState();
  }

  void updateUI() async {
    dataKeeper = widget.dataKeeper;
    await dataKeeper.getHourlyData();
    setState(() {});
  }



  @override
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
              child: Column(
                children: hourlyCards(),
              ),
            ),
          ]
        )
      )
    );
  }
}

