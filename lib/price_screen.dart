import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:section14bronze/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  //String selectedCurrencyETC = 'ETC';
  //String selectedCurrencyLTC = 'LTC';

  String baseAsset = '';
  String baseAssetetc = '';
  String baseAssetltc = '';
  String quoteAsset = '';
  String quoteAssetetc = '';
  String quoteAssetltc = '';
  double? exchangeRate;
  double? exchangeRateETC;
  double? exchangeRateLTC;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      dropdownItems.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = currenciesList.map((c) => Text(c)).toList();

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currenciesList[index];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final url = Uri.parse(
        "https://api-realtime.exrates.coinapi.io/v1/exchangerate/BTC/$selectedCurrency");
    final urletc = Uri.parse(
        "https://api-realtime.exrates.coinapi.io/v1/exchangerate/ETC/$selectedCurrency");
    final urlltc = Uri.parse(
        "https://api-realtime.exrates.coinapi.io/v1/exchangerate/LTC/$selectedCurrency");


    final headers = {
      'Accept': 'text/plain',
      'X-CoinAPI-Key': dotenv.env['COIN_API_KEY'] ?? '',
    };

//btc
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        setState(() {
          baseAsset = jsonData['asset_id_base'];
          quoteAsset = jsonData['asset_id_quote'];
          exchangeRate = jsonData['rate']?.toDouble();
        });

        print("Success: $baseAsset to $quoteAsset = $exchangeRate");
      } else {
        print("Failed with status: ${response.statusCode}");
        print("Body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }

    //etc
    try {
      final responseetc = await http.get(urletc, headers: headers);

      if (responseetc.statusCode == 200) {
        final jsonDataetc = jsonDecode(responseetc.body);

        setState(() {
          baseAssetetc = jsonDataetc['asset_id_base'];
          quoteAssetetc = jsonDataetc['asset_id_quote'];
          exchangeRateETC = jsonDataetc['rate']?.toDouble();
        });

        print("Success: $baseAssetetc to $quoteAssetetc = $exchangeRateETC");
      } else {
        print("Failed with status: ${responseetc.statusCode}");
        print("Body: ${responseetc.body}");
      }
    } catch (e) {
      print("Error: $e");
    }



    //ltc

    try {
      final responseltc = await http.get(urlltc , headers: headers);

      if (responseltc.statusCode == 200) {
        final jsonDataltc = jsonDecode(responseltc.body);

        setState(() {
         baseAssetltc = jsonDataltc['asset_id_base'];
         quoteAssetltc = jsonDataltc['asset_id_quote'];
          exchangeRateLTC = jsonDataltc['rate']?.toDouble();
        });

        print("Success: $baseAssetltc to $quoteAssetltc = $exchangeRateLTC");
      } else {
        print("Failed with status: ${responseltc.statusCode}");
        print("Body: ${responseltc.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    String displayText = exchangeRate == null
        ? '1 BTC = ? $selectedCurrency'
        : '1 $baseAsset = ${exchangeRate?.toStringAsFixed(2)} $quoteAsset';

    String displayTextETC = exchangeRate == null
        ? '1 ETH = ? $selectedCurrency'
        : '1 ETH = ${exchangeRateETC?.toStringAsFixed(2)} $quoteAsset';

    String displayTextLTC = exchangeRate == null
        ? '1 LTC = ? $selectedCurrency'
        : '1 LTC = ${exchangeRate?.toStringAsFixed(2)} $quoteAsset';

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      displayText,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      displayTextETC,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      displayTextLTC,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
