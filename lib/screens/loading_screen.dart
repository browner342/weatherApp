import 'package:clima/screens/weatherNow_screen.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'weatherNow_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/dataKeeper.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  DataKeeper dataKeeper = DataKeeper();

  void getLocationData () async {
    await dataKeeper.getWeather(PlaceType.myLocation, '');

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
