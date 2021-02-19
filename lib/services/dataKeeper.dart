import 'package:flutter/material.dart';

class DataKeeper {
  int temperature;
  int condition;
  String cityName;
  String weatherIcon;
  Color weatherBackGroundColor;
  String weatherDescp;
  double lon;
  double lat;

  List<int> tempHourly = new List(5); //TODO: change from hardcode
  List<int> condHourly = new List(5);
  List<String> iconHourly = new List(5);
  List<Color> colorHourly = new List(5);
  List<int> hourHourly = new List(5);
}