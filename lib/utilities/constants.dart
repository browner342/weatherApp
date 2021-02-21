import 'package:flutter/material.dart';

const kCardWeeklyAmount = 7;
const kCardHourlyAmount = 48;
const String kApiKey = '6cdc9fa0075e4f00d9a0fb9bd5b673b9';

const kTempTextStyle = TextStyle(
  fontFamily: 'Hind Siliguri',
  fontSize: 88.0,
);

const kCityNameTextStyle = TextStyle(
  fontFamily: 'Hind Siliguri',
  fontSize: 38.0,
);

const kWeatherDescp = TextStyle(
  fontFamily: 'Hind Siliguri',
  fontSize: 25.0,
);

const kWeekDay = TextStyle(
  fontFamily: 'Hind Siliguri',
  fontSize: 18.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Hind Siliguri',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color:Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);

const kAlertNoConnection = 'No internet connection or location switched off';