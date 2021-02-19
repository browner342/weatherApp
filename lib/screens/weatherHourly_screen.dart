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


  @override
  void initState() {
    updateUI();
    super.initState();
  }

  void updateUI() async {
    dataKeeper = widget.dataKeeper;
    var weatherData = await weatherModel.getHourlyWeather(dataKeeper.lat, dataKeeper.lon);

    if(weatherData == null){
      //TODO
    }else{
      for(var i = 0; i < 5; i++){ //TODO: change hard code 5
        if(weatherData['hourly'][i]['temp'].runtimeType == double){
          double temp = weatherData['hourly'][i]['temp'];
          dataKeeper.tempHourly[i] = temp.toInt();
        } else {
          dataKeeper.tempHourly[i] = weatherData['hourly'][i]['temp'];
        }

        dataKeeper.condHourly[i] = weatherData['hourly'][i]['weather'][0]['id'];

        weatherModel.getWeatherValues(dataKeeper.condHourly[i]);
        dataKeeper.colorHourly[i] = weatherModel.color;
        dataKeeper.iconHourly[i] = weatherModel.icon;
        dataKeeper.hourHourly[i] = DateTime.now().hour + i;
      }
    }
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
                children: [
                  Expanded(
                    child: HourCard(
                      temperature: dataKeeper.tempHourly[0],
                      backgrounColor: dataKeeper.colorHourly[0],
                      icon: dataKeeper.iconHourly[0],
                      hour: dataKeeper.hourHourly[0],
                    ),
                  ),
                  Expanded(
                    child: HourCard(
                      temperature: dataKeeper.tempHourly[1],
                      backgrounColor: dataKeeper.colorHourly[1],
                      icon: dataKeeper.iconHourly[1],
                      hour: dataKeeper.hourHourly[1],
                    ),
                  ),
                  Expanded(
                    child: HourCard(
                      temperature: dataKeeper.tempHourly[2],
                      backgrounColor: dataKeeper.colorHourly[2],
                      icon: dataKeeper.iconHourly[2],
                      hour: dataKeeper.hourHourly[2],
                    ),
                  ),
                  Expanded(
                    child: HourCard(
                      temperature: dataKeeper.tempHourly[3],
                      backgrounColor: dataKeeper.colorHourly[3],
                      icon: dataKeeper.iconHourly[3],
                      hour: dataKeeper.hourHourly[3],
                    ),
                  ),
                  Expanded(
                    child: HourCard(
                      temperature: dataKeeper.tempHourly[4],
                      backgrounColor: dataKeeper.colorHourly[4],
                      icon: dataKeeper.iconHourly[4],
                      hour: dataKeeper.hourHourly[4],
                    ),
                  ),
                ],
              ),
            ),
          ]
        )
      )
    );
  }
}

