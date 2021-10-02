import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/crypto_currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency;

  List<CryptoCurrency> cryptoCurrencies = [
    CryptoCurrency(currency: 'BTC'),
    CryptoCurrency(currency: 'ETH'),
    CryptoCurrency(currency: 'LTC'),
  ];

  @override
  void initState() {
    super.initState();
    selectedCurrency = currenciesList.first;
  }

  CupertinoPicker makeCupertinoPicker() {
    List<Text> items = [];
    for (String currency in currenciesList) {
      items.add(
        Text(
          currency,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
      },
      children: items,
    );
  }

  DropdownButton<String> makeDropdownButton() {
    List<DropdownMenuItem<String>> items = [];
    for (String currency in currenciesList) {
      items.add(
        DropdownMenuItem(
          child: Text(
            currency,
            style: TextStyle(color: Colors.black54),
          ),
          value: currency,
        ),
      );
    }
    return DropdownButton(
      value: selectedCurrency,
      focusColor: Colors.white,
      items: items,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  Widget makeCurrencyPickerWidget() {
    print(Platform.environment);
    if (Platform.isIOS) {
      return makeCupertinoPicker();
    } else if (Platform.isAndroid) {
      return makeDropdownButton();
    } else {
      return Center(child: Text('Unsupported platform'));
    }
  }

  List<Widget> makeCryptoCurrencies() {
    List<Widget> results = [];
    for (int i = 0; i < cryptoCurrencies.length; i++) {
      results.add(
        _CryptoCurrency(
          cryptoCurrency: cryptoCurrencies[i],
          fiatCurrency: selectedCurrency,
        ),
      );
      if (i < cryptoCurrencies.length - 1) {
        results.add(const SizedBox(height: 32.0));
      }
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
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
              children: makeCryptoCurrencies(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: makeCurrencyPickerWidget(),
          ),
        ],
      ),
    );
  }
}

class _CryptoCurrency extends StatelessWidget {
  final CryptoCurrency cryptoCurrency;
  final String fiatCurrency;

  _CryptoCurrency({
    @required this.cryptoCurrency,
    @required this.fiatCurrency,
  });

  @override
  Widget build(BuildContext context) {
    cryptoCurrency.getExchangeRate(fiatCurrency: fiatCurrency);
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 ${cryptoCurrency.currency} = ${cryptoCurrency.rate.toInt() ?? '?'} $fiatCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
