import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../services/weather.dart';

class DataKeeper extends ChangeNotifier{

  int temperature;
  int condition;
  String cityName;
  String weatherIcon;
  Color weatherBackGroundColor;
  String weatherDescp;
  double lon ;
  double lat;
  bool isConnected;

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


  Future <void> getWeather(PlaceType placeType, String typedCityName) async {
    var weatherData;
    try {
      if(placeType == PlaceType.myLocation){
        weatherData = await WeatherModel().getLocationWeather();
        this._decodeWeatherNow(weatherData);
      }else if(placeType == PlaceType.typedCity){
        weatherData = await WeatherModel().getCityWeather(typedCityName);
        this._decodeWeatherNow(weatherData);
      }

      weatherData = await WeatherModel().getOverAllWeather(this.lat, this.lon);
      this._decodeWeatherOverall(weatherData);
    } catch(e){
      print(e);
    }

    notifyListeners();
  }

  void _decodeWeatherNow(dynamic weatherData){
    if(weatherData == null){
      isConnected = false;
      cityName = '';
      lon = 0;
      lat = 0;
      condition = 0;
      weatherIcon = '';
      weatherBackGroundColor = Colors.black;
      temperature = 0;
      weatherDescp = 'No internet connection or location switched off';
      return;
    }
    isConnected = true;
    WeatherModel weatherModel = WeatherModel();
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();

    cityName = weatherData['name'];
    lon = weatherData['coord']['lon'];
    lat = weatherData['coord']['lat'];
    condition = weatherData['weather'][0]['id'];
    weatherModel.getWeatherValues(condition);
    weatherIcon = weatherModel.icon;
    weatherBackGroundColor = weatherModel.color;
    weatherDescp = weatherModel.descp;

  }

  void _decodeWeatherOverall(dynamic weatherData) {
    WeatherModel weatherModel = WeatherModel();

    if(weatherData == null){
      return;
    }

    for(var i = 0; i < kCardWeeklyAmount; i++){
      if(weatherData['daily'][i]['temp']['max'].runtimeType == double){
        double temp = weatherData['daily'][i]['temp']['max'];
        tempMaxDaily[i] = temp.toInt();

        temp = weatherData['daily'][i]['temp']['min'];
        tempMinDaily[i] = temp.toInt();
      } else {
        tempMaxDaily[i] = weatherData['daily'][i]['temp']['max'];
        tempMinDaily[i] = weatherData['daily'][i]['temp']['min'];
      }

      condDaily[i] = weatherData['daily'][i]['weather'][0]['id'];

      weatherModel.getWeatherValues(condDaily[i]);
      colorDaily[i] = weatherModel.color;
      iconDaily[i] = weatherModel.icon;

      Duration duration = Duration(days: i);
      dateDaily[i] = DateTime.now().add(duration);
    }

    for(var i = 0; i < kCardHourlyAmount; i++){
      if(weatherData['hourly'][i]['temp'].runtimeType == double){
        double temp = weatherData['hourly'][i]['temp'];
        tempHourly[i] = temp.toInt();
      } else {
        tempHourly[i] = weatherData['hourly'][i]['temp'];
      }

      condHourly[i] = weatherData['hourly'][i]['weather'][0]['id'];

      weatherModel.getWeatherValues(condHourly[i]);
      colorHourly[i] = weatherModel.color;
      iconHourly[i] = weatherModel.icon;

      Duration duration = new Duration(hours: i);
      dateHourly[i] = DateTime.now().add(duration);
    }

  }

}