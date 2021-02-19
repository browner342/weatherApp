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
  Color weatherBackGroundColor;
  String weatherDescp;

  
  WeatherModel weatherModel = WeatherModel();

  void updateUI(dynamic weatherData){
    if(weatherData == null){
      temperature = 0;
      weatherIcon = 'Error';
      cityName = '';
      condition = 100;
      weatherBackGroundColor = Colors.white;
      weatherDescp ='';
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
    weatherModel.getWeatherValues(condition);
    weatherIcon = weatherModel.icon;
    weatherBackGroundColor = weatherModel.color;
    weatherDescp = weatherModel.descp;
  }

  @override
  void initState() {
    updateUI(widget.locationData);
    print(condition);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: weatherBackGroundColor,
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
                        "$cityName",
                        textAlign: TextAlign.center,
                        style: kCityNameTextStyle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        "$weatherDescp",
                        textAlign: TextAlign.center,
                        style: kWeatherDescp,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                  ],
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
