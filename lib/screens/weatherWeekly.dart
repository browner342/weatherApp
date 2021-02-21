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

  List<Widget> hourlyCards(){
    List<Widget> cards = [];

    for(var i = 0; i < kCardAmount; i++){
      var item = Expanded(
        child: DailyCard(
          temperatureMax: dataKeeper.tempDailyMax[i],
          temperatureMin: dataKeeper.tempDailyMin[i],
          backgroundColor: dataKeeper.colorDaily[i],
          icon: dataKeeper.iconDaily[i],
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
    var weatherData = await weatherModel.getWeeklyWeather(dataKeeper.lat, dataKeeper.lon);
    setState(() {
      if(weatherData == null){
        //TODO
      }else{
        for(var i = 0; i < kCardAmount; i++){
          if(weatherData['daily'][i]['temp']['max'].runtimeType == double){
            double temp = weatherData['daily'][i]['temp']['max'];
            dataKeeper.tempDailyMax[i] = temp.toInt();

            temp = weatherData['daily'][i]['temp']['min'];
            dataKeeper.tempDailyMin[i] = temp.toInt();
          } else {
            dataKeeper.tempDailyMax[i] = weatherData['daily'][i]['temp']['max'];
            dataKeeper.tempDailyMin[i] = weatherData['daily'][i]['temp']['min'];
          }

          dataKeeper.condDaily[i] = weatherData['daily'][i]['weather'][0]['id'];

          weatherModel.getWeatherValues(dataKeeper.condDaily[i]);
          dataKeeper.colorDaily[i] = weatherModel.color;
          dataKeeper.iconDaily[i] = weatherModel.icon;

        }
      }
    });


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

