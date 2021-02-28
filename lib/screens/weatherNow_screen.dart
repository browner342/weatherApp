import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'weatherWeekly_screen.dart';
import 'weatherHourly_screen.dart';
import 'city_screen.dart';

import 'package:clima/utilities/constants.dart';
import '../services/dataKeeper.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen({this.dataKeeper,});

  final DataKeeper dataKeeper;


  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  DataKeeper dataKeeper = DataKeeper();
  bool showSpinner = false;

  @override
  void initState() {
    dataKeeper = widget.dataKeeper;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
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
                        setState(() {
                          showSpinner = true;
                        });
                        await dataKeeper.getWeather(PlaceType.myLocation, '');

                        setState(() {
                          showSpinner = false;
                        });
                        // if(dataKeeper.isConnected){
                        //   setState(() {});
                        // }
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
                        setState(() {
                          showSpinner = true;
                        });
                        if(typedName != null){
                          await dataKeeper.getWeather(PlaceType.typedCity, typedName);

                          // if(dataKeeper.isConnected){
                          //   setState(() {});
                          // }
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                    FlatButton( // weather hourly
                      onPressed: () {
                        if(dataKeeper.isConnected){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                      onPressed: () {
                        if(dataKeeper.isConnected) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
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
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem> [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.near_me),
        //       label: 'My localization',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.near_me),
        //       label: 'My localization',
        //     ),
        //   ],
        //   onTap: ,
        // ),
      ),
    );
  }
}
