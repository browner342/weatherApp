import '../services/location.dart';
import '../services/networking.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';


class WeatherModel {

  String icon;
  Color color;
  String descp;


  Future <dynamic> getCityWeather(String cityName) async{
    try {
      NetworkHelper networkHelper = NetworkHelper('http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$kApiKey&units=metric');
      var weatherData = await networkHelper.getData();

      return weatherData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future <dynamic> getLocationWeather() async{
    Location location = Location();

    await location.getLocation();

    try{
      NetworkHelper networkHelper = NetworkHelper('http://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');
      var weatherData = await networkHelper.getData();

      return weatherData;

    } catch (e){
      print(e);
      return null;
    }

  }

  Future <dynamic> getOverAllWeather(double lat, double lon) async {

    try{
      NetworkHelper networkHelper = NetworkHelper('http://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$kApiKey&units=metric');
      var weatherData = await networkHelper.getData();

      return weatherData;
    } catch (e){
      print(e);
      return null;
    }
  }

  void getWeatherValues(int condition) { //ThunderStorm
    if (condition < 300) {
      icon =  '🌩';
      descp = 'Stormy';
      color = Color(0xFF381EE6);
    } else if (condition < 400) { //Drizzle
      icon = '🌧';
      descp = 'Drizzly';
      color = Color(0xFF168EEF);
    } else if (condition < 600) { //Rain
      icon = '☔️';
      descp = 'Rainy';
      color = Color(0xFF168EEF);
    } else if (condition < 700) { //Snow
      icon = '☃️';
      descp = 'Snowy';
      color = Color(0xFFD8E1F2);
    } else if (condition < 800) { //Atmosphere
      icon = '🌫';
      descp = 'Clear sky';
      color = Color(0xFF0085E6);
    } else if (condition == 800) { //Sun
      icon = '☀️';
      descp ='Sunny';
      color = Color(0xFFFFD969);
    } else if (condition <= 804) { //Clouds
      icon = '☁️';
      descp = 'Cloudy';
      color = Color(0xFF5C70C2);
    } else {  //other
      icon = '🤷‍';
      descp = 'Other';
      color =  Color(0xFFDFE6EA);
    }
  }

}
