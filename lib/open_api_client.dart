import 'dart:convert';

import 'package:http/http.dart' as http;

const kAPIKey = '<CHECK EMAIL>';
const kBaseURL = 'https://rest.coinapi.io/v1/exchangerate';

class OpenAPIClient {
  String cryptoCurrency;
  String fiatCurrency;

  OpenAPIClient({this.cryptoCurrency, this.fiatCurrency});

  Future<double> getExchangeRate() async {
    final url = Uri.parse('$kBaseURL/$cryptoCurrency/$fiatCurrency');
    final headers = {
      'X-CoinAPI-Key': kAPIKey,
    };
    final response = await http.get(url, headers: headers);
    if(response.statusCode == 200) {
      double rate = jsonDecode(response.body)['rate'];
      return rate;
    } else {
      print(response.body);
      return -1;
    }
  }
}
