import 'package:clima/screens/weatherNow_screen.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'weatherNow_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/dataKeeper.dart';
import 'package:provider/provider.dart';

bool test = false;

class LoadingScreen extends StatelessWidget {

  void getLocationData (context) async {
    //TODO: Do it properly, dummy bool lean value
    if(test){
      return;
    }
    test = true;
    // await dataKeeper.getWeather(PlaceType.myLocation, '');
    await Provider.of<DataKeeper>(context).getWeather(PlaceType.myLocation, '');
    //Go to the next page
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
    }));
  }

  // @override
  // void initState() {
  //   getLocationData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    getLocationData(context);
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
