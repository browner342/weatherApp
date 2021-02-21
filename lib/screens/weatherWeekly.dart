import 'package:clima/components/dailyCard.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../services/dataKeeper.dart';
import '../services/weather.dart';

class WeatherWeeklyScreen extends StatefulWidget {
  WeatherWeeklyScreen({this.dataKeeper});

  DataKeeper dataKeeper = DataKeeper();

  @override
  _WeatherWeeklyScreenState createState() => _WeatherWeeklyScreenState();
}

class _WeatherWeeklyScreenState extends State<WeatherWeeklyScreen>{
  WeatherModel weatherModel = WeatherModel();
  DataKeeper dataKeeper = DataKeeper();

  List<Widget> dailyCards(){
    List<Widget> cards = [];

    for(var i = 0; i < kCardAmount; i++){
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


  void updateUI() async {
    dataKeeper = widget.dataKeeper;
    var weatherData = await weatherModel.getWeeklyWeather(dataKeeper.lat, dataKeeper.lon);

    setState(() {
        for(var i = 0; i < kCardAmount; i++){
          if(weatherData['daily'][i]['temp']['max'].runtimeType == double){
            double temp = weatherData['daily'][i]['temp']['max'];
            dataKeeper.tempMaxDaily[i] = temp.toInt();

            temp = weatherData['daily'][i]['temp']['min'];
            dataKeeper.tempMinDaily[i] = temp.toInt();
          } else {
            dataKeeper.tempMaxDaily[i] = weatherData['daily'][i]['temp']['max'];
            dataKeeper.tempMinDaily[i] = weatherData['daily'][i]['temp']['min'];
          }

          dataKeeper.condDaily[i] = weatherData['daily'][i]['weather'][0]['id'];

          weatherModel.getWeatherValues(dataKeeper.condDaily[i]);
          dataKeeper.colorDaily[i] = weatherModel.color;
          dataKeeper.iconDaily[i] = weatherModel.icon;

          Duration duration = Duration(days: i);
          dataKeeper.dateDaily[i] = DateTime.now().add(duration);
        }
      }
    );
  }

  @override
  void initState() {
    updateUI();
    super.initState();
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
                      children: dailyCards(),
                    ),
                  ),
                ]
            )
        )
    );
  }
}

