import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../services/weather.dart';

class DataKeeper {
  int temperature;
  int condition;
  String cityName;
  String weatherIcon;
  Color weatherBackGroundColor;
  String weatherDescp;
  double lon ;
  double lat;

  List<int> tempHourly = new List(kCardHourlyAmount);
  List<int> condHourly = new List(kCardHourlyAmount);
  List<String> iconHourly = new List(kCardHourlyAmount);
  List<Color> colorHourly = new List(kCardHourlyAmount);
  List<DateTime> dateHourly = new List(kCardHourlyAmount);

  List<int> tempMaxDaily = new List(kCardWeeklyAmount);
  List<int> tempMinDaily = new List(kCardWeeklyAmount);
  List<int> condDaily = new List(kCardWeeklyAmount);
  List<String> iconDaily = new List(kCardWeeklyAmount);
  List<Color> colorDaily = new List(kCardWeeklyAmount);
  List<DateTime> dateDaily = new List(kCardWeeklyAmount);

  Future<dynamic> getWeeklyData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getWeeklyWeather(this.lat, this.lon);

      for(var i = 0; i < kCardWeeklyAmount; i++){
        if(weatherData['daily'][i]['temp']['max'].runtimeType == double){
          double temp = weatherData['daily'][i]['temp']['max'];
          this.tempMaxDaily[i] = temp.toInt();

          temp = weatherData['daily'][i]['temp']['min'];
          this.tempMinDaily[i] = temp.toInt();
        } else {
          this.tempMaxDaily[i] = weatherData['daily'][i]['temp']['max'];
          this.tempMinDaily[i] = weatherData['daily'][i]['temp']['min'];
        }

        this.condDaily[i] = weatherData['daily'][i]['weather'][0]['id'];

        weatherModel.getWeatherValues(this.condDaily[i]);
        this.colorDaily[i] = weatherModel.color;
        this.iconDaily[i] = weatherModel.icon;

        Duration duration = Duration(days: i);
        this.dateDaily[i] = DateTime.now().add(duration);
      }
      return weatherData;
    }
  Future<dynamic> getHourlyData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getHourlyWeather(this.lat, this.lon);

    for(var i = 0; i < kCardHourlyAmount; i++){
        if(weatherData['hourly'][i]['temp'].runtimeType == double){
          double temp = weatherData['hourly'][i]['temp'];
          this.tempHourly[i] = temp.toInt();
        } else {
          this.tempHourly[i] = weatherData['hourly'][i]['temp'];
        }

        this.condHourly[i] = weatherData['hourly'][i]['weather'][0]['id'];

        weatherModel.getWeatherValues(this.condHourly[i]);
        this.colorHourly[i] = weatherModel.color;
        this.iconHourly[i] = weatherModel.icon;

        Duration duration = new Duration(hours: i);
        this.dateHourly[i] = DateTime.now().add(duration);
      }
    return weatherData;
    }

}