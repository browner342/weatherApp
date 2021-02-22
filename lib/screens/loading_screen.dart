import 'package:clima/screens/weatherNow_screen.dart';
import 'package:flutter/material.dart';
import 'weatherNow_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/weather.dart';
import '../services/dataKeeper.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  DataKeeper dataKeeper = DataKeeper();
  WeatherModel weatherModel = WeatherModel();


  void getLocationData () async {
    //Getting location with current weather
    var weatherDataCurrent = await WeatherModel().getLocationWeather();
    dataKeeper.getWeatherDataNow(weatherDataCurrent);

    //Getting weather for the future
    if(dataKeeper.isConnected){
      weatherDataCurrent = await WeatherModel().getHourlyWeather(dataKeeper.lat, dataKeeper.lon);
      dataKeeper.getWeatherData(weatherDataCurrent);
    }

    //Go to the next page
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(dataKeeper: dataKeeper,);
    }));
  }


  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
