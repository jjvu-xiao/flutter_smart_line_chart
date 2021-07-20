import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_line_chart/common/pair.dart';
import 'package:flutter_smart_line_chart/line_chart/animated_line_chart.dart';
import 'package:flutter_smart_line_chart/line_chart/area_line_chart.dart';
import 'package:flutter_smart_line_chart/line_chart/line_chart.dart';
import 'package:intl/intl.dart';

import 'chart_series.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'fl_animated_chart demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with FakeChartSeries {
  int chartIndex = 0;
  Map<DateTime, double> datas1 = {}, data2 = {}, data3 = {};

  @override
  void initState() {
    getDatas();
  }

  @override
  Widget build(BuildContext context) {
    Map<DateTime, double> line1 = createLine2();
    Map<DateTime, double> line2 = createLine2_2();
    Map<DateTime, double> line3 = createLine2_3();

    LineChart chart= LineChart.fromDateTimeMaps(
          [datas1], [Colors.green], [''],
          tapTextFontWeight: FontWeight.w400);

    return Scaffold(
   /*   appBar: AppBar(
        title: Text(widget.title),
      ),*/
      body: Container(
        margin: EdgeInsets.only(top: 30, left: 20, right: 10, bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: AnimatedLineChart(
                  chart,
                  key: UniqueKey(),
                  dateFormatPattern: 'HH:mm',
                ), //Unique key to force animations
              )
            ),
          ]
        )
      )
    );
  }

  Future<void> getDatas() async {
    DateFormat df = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime d = DateTime(2020);
    debugPrint(df.format(d).toString());
    String json = await rootBundle.loadString("assets/data.json");
    List m = jsonDecode(json);
    List m1 = m[0]['beforeYesterdayFlowLine'];
    List m2 = m[0]['yesterdayFlowLine'];
    List m3 = m[0]['todayFlowLine'];
    m1.forEach((e) {
      DateTime tmp = df.parse(e['fixedTime'].toString());
      datas1[tmp] = e['dataValue'];
    });
    debugPrint(m.length.toString());
    setState(() {

    });
  }
}
