import 'package:clima/screens/weatherWeekly_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

import 'city_screen.dart';
import 'weatherHourly_screen.dart';

import '../services/weather.dart';
import '../services/dataKeeper.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.dataKeeper,});

  final DataKeeper dataKeeper;


  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var weatherData;

  DataKeeper dataKeeper = DataKeeper();
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    dataKeeper = widget.dataKeeper;
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
                      dataKeeper.getWeatherDataNow(weatherData);

                      weatherData = await WeatherModel().getHourlyWeather(dataKeeper.lat, dataKeeper.lon);
                      dataKeeper.getWeatherData(weatherData);

                      if(dataKeeper.isConnected){
                        setState(() {});
                      }
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
                        dataKeeper.getWeatherDataNow(weatherData);

                        weatherData = await WeatherModel().getHourlyWeather(dataKeeper.lat, dataKeeper.lon);
                        dataKeeper.getWeatherData(weatherData);

                        if(dataKeeper.isConnected){
                          setState(() {});
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
                      if(dataKeeper.isConnected){
                        await Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return WeatherHourlyScreen(dataKeeper: dataKeeper);
                        }));
                      } else {
                        //TODO:alert no internet connection
                        print('no internet connection');
                      }
                    },
                    child: Icon(
                      Icons.access_time,
                      size: 50.0,
                    ),
                  ),
                  FlatButton( // weather for week
                    onPressed: () async {
                      if(dataKeeper.isConnected) {
                        await Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return WeatherWeeklyScreen(dataKeeper: dataKeeper);
                        }));
                      }else {
                        //TODO:alert no internet connection
                        print('no internet connection');
                      }

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
