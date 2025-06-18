import 'package:flutter/material.dart';
import 'price_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'coin_data.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  print("Loaded API Key: ${dotenv.env['COIN_API_KEY']}");
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(),

    );
  }
}
