import 'open_api_client.dart';

class CryptoCurrency {
  final String currency;
  double _rate = -1;

  CryptoCurrency({this.currency});

  Future<void> getExchangeRate({String fiatCurrency}) async {
    final openAPIClient =
        OpenAPIClient(cryptoCurrency: currency, fiatCurrency: fiatCurrency);
    _rate = await openAPIClient.getExchangeRate();
  }

  double get rate => _rate;
}
