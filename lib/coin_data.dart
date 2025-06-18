// Add your imports here.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'COIN_API_KEY';

class CoinData {
  //Create your getCoinData() method here.

 // String url = "https://api-realtime.exrates.coinapi.io/v1/exchangerate/BTC/USD";

  /*Map payload = {}
  Map<String, String> headers = {
  'Accept': 'text/plain',
  'Authorization': 'COIN_API_KEY'
  }*/


}
