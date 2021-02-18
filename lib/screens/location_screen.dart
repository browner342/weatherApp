import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationData});

  final locationData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  int temperature;
  int condition;
  String cityName;
  var weatherData;
  String weatherIcon;
  String weatherMessg;

  
  WeatherModel weatherModel = WeatherModel();

  void updateUI(dynamic weatherData){
    if(weatherData == null){
      temperature = 0;
      weatherIcon = 'Error';
      weatherMessg = 'Unable to get weather data';
      cityName = '';
      condition = 100;
      return;
    }
    if ( weatherData['main']['temp'].runtimeType == double){
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
    }else{
      temperature = weatherData['main']['temp'];
    }

    condition = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
    weatherIcon = weatherModel.getWeatherIcon(condition);
    weatherMessg = weatherModel.getMessage(temperature);
  }

  @override
  void initState() {
    updateUI(widget.locationData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      weatherData = await weatherModel.getLocationWeather();
                      print(weatherData);
                      setState(() {
                        updateUI(weatherData);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));

                      if(typedName != null){
                        weatherData = await weatherModel.getCityWeather(typedName);

                        if(weatherData != null){
                          setState(() {
                            updateUI(weatherData);
                          });
                        }
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessg in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
