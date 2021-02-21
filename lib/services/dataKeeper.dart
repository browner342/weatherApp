import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

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
}