import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

import 'city_screen.dart';
import 'weatherHourly_screen.dart';

import '../services/weather.dart';
import '../services/dataKeeper.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationData,});

  final locationData;


  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var weatherData;

  DataKeeper dataKeeper = DataKeeper();
  WeatherModel weatherModel = WeatherModel();

  void updateUI(dynamic weatherData,){

    if(weatherData == null){
      dataKeeper.temperature = 0;
      dataKeeper.weatherIcon = 'Error';
      dataKeeper.cityName = '';
      dataKeeper.condition = 100;
      dataKeeper.weatherBackGroundColor = Colors.white;
      dataKeeper.weatherDescp ='';
      dataKeeper.lon = 0;
      dataKeeper.lat = 0;
      return;
    }
    if ( weatherData['main']['temp'].runtimeType == double){
      double temp = weatherData['main']['temp'];
      dataKeeper.temperature = temp.toInt();
    }else{
      dataKeeper.temperature = weatherData['main']['temp'];
    }

    dataKeeper.condition = weatherData['weather'][0]['id'];
    dataKeeper.cityName = weatherData['name'];
    dataKeeper.lon = weatherData['coord']['lon'];
    dataKeeper.lat = weatherData['coord']['lat'];

    weatherModel.getWeatherValues(dataKeeper.condition);
    dataKeeper.weatherIcon = weatherModel.icon;
    dataKeeper.weatherBackGroundColor = weatherModel.color;
    dataKeeper.weatherDescp = weatherModel.descp;


  }

  @override
  void initState() {
    updateUI(widget.locationData,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: dataKeeper.weatherBackGroundColor,
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        "${dataKeeper.cityName}",
                        textAlign: TextAlign.center,
                        style: kCityNameTextStyle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        "${dataKeeper.weatherDescp}",
                        textAlign: TextAlign.center,
                        style: kWeatherDescp,
                      ),
                    ),
                    Text(
                      '${dataKeeper.weatherIcon}',
                      style: kConditionTextStyle,
                    ),
                    Text(
                      '${dataKeeper.temperature}',
                      style: kTempTextStyle,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton( // My location now
                    onPressed: () async {
                      weatherData = await weatherModel.getLocationWeather();
                      setState(() {
                        updateUI(weatherData,);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton( //Chosen city
                    onPressed: () async {
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));

                      if(typedName != null){
                        weatherData = await weatherModel.getCityWeather(typedName);

                        if(weatherData != null){
                          setState(() {
                            updateUI(weatherData,);
                          });
                        }
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                  FlatButton( // weather hourly
                    onPressed: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return WeatherHourlyScreen(dataKeeper: dataKeeper);
                      }));
                    },
                    child: Icon(
                      Icons.access_time,
                      size: 50.0,
                    ),
                  ),
                  FlatButton( // weather for week
                    onPressed: () async {
                      weatherData = await weatherModel.getLocationWeather();
                      setState(() {
                        //updateUI(weatherData);
                      });
                    },
                    child: Icon(
                      Icons.calendar_today,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
