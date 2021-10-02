import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

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
        selectedCurrency = currenciesList[selectedIndex];
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
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
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
