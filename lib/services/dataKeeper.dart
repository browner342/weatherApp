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

  List<int> tempHourly = new List(kCardAmount);
  List<int> condHourly = new List(kCardAmount);
  List<String> iconHourly = new List(kCardAmount);
  List<Color> colorHourly = new List(kCardAmount);
  List<int> hourHourly = new List(kCardAmount);

  List<int> tempMaxDaily = new List(kCardAmount);
  List<int> tempMinDaily = new List(kCardAmount);
  List<int> condDaily = new List(kCardAmount);
  List<String> iconDaily = new List(kCardAmount);
  List<Color> colorDaily = new List(kCardAmount);
  List<DateTime> dateDaily = new List(kCardAmount);

  Future<dynamic> getWeeklyData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getWeeklyWeather(this.lat, this.lon);

      for(var i = 0; i < kCardAmount; i++){
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

    for(var i = 0; i < kCardAmount; i++){
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
        this.hourHourly[i] = DateTime.now().add(duration).hour;
      }
    return weatherData;
    }

}