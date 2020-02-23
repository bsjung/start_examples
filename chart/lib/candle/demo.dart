import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:start_chart/start_chart.dart';
import 'package:http/http.dart' as http;

class Demo extends StatefulWidget {
  Demo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Demo> {
  List<CandleEntity> datas;
  bool showLoading = true;
  MainState _mainState = MainState.MA;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool isLine = false;
  List<DepthEntity> _bids, _asks;

  @override
  void initState() {
    super.initState();
    initData('assets/btcusdt.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17212F),
      body: ListView(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              height: 450,
              width: double.infinity,
              child: CandleWidget(
                datas,
                isLine: isLine,
                mainState: _mainState,
                secondaryState: _secondaryState,
                fixedLength: 2,
                timeFormat: TimeFormat.YEAR_MONTH_DAY,
              ),
            ),
            if (showLoading)
              Container(
                  width: double.infinity,
                  height: 450,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator()),
          ]),
        ],
      ),
    );
  }

  void initData(String json_file) {
    rootBundle.loadString(json_file).then((result) {
      Map parseJson = jsonDecode(result);
      List list = parseJson['data'];
      datas = list
          .map((item) => CandleEntity.fromJson(item))
          .toList()
          .reversed
          .toList()
          .cast<CandleEntity>();
      DataUtil.calculate(datas);
      showLoading = false;
      setState(() {});
    });
  }

}
