import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'weatherWeekly_screen.dart';
import 'weatherHourly_screen.dart';
import 'city_screen.dart';

import 'package:clima/utilities/constants.dart';
import '../services/dataKeeper.dart';


class LocationScreen extends StatelessWidget {

  bool _showSpinner = false;
  int _selectedIndex = 0;

  // List<BottomNavigationBarItem> bottomNavigationWidgets = [
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.near_me),
  //     label: 'My localization',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.location_city),
  //     label: 'City location',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.access_time),
  //     label: 'Hourly',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.calendar_today),
  //     label: 'Weekly',
  //   ),
  // ];

  Future <dynamic> noConnectionDialog(context){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Connection problem'),
            content: Text('Turn the internet on or switch location on.'),
          );
        }
    );
  }

  // void _onTapped(int index){
  //     setState(() {
  //       _selectedIndex = index;
  //     });
  // }

  // @override
  // void initState() {
  //   // dataKeeper = widget.dataKeeper;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataKeeper>(
      builder: (context, dataKeeper, child){
        return ModalProgressHUD(
          inAsyncCall: _showSpinner,
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
                            // setState(() {
                            //   _showSpinner = true;
                            // });
                            await dataKeeper.getWeather(PlaceType.myLocation, '');

                            // setState(() {
                            //   _showSpinner = false;
                            // });
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
                            // setState(() {
                            //   _showSpinner = true;
                            // });
                            if(typedName != null){
                              await dataKeeper.getWeather(PlaceType.typedCity, typedName);
                            }
                            // setState(() {
                            //   _showSpinner = false;
                            // });
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
                                return WeatherHourlyScreen();
                              }));
                            } else {
                              noConnectionDialog(context);
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
                                return WeatherWeeklyScreen();
                              }));
                            }else {
                              noConnectionDialog(context);
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
            //   items: bottomNavigationWidgets,
            //   fixedColor: Colors.white,
            //   currentIndex: _selectedIndex,
            //   onTap: _onTapped,
            // ),
          ),
        );
      },
    );
  }
}
