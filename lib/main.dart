import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:provider/provider.dart';
import 'services/dataKeeper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataKeeper(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: LoadingScreen(),
      ),
    );
  }
}
