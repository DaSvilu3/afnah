import 'package:flutter/material.dart';
import 'model/catrgory.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

const Color greenColor = const Color(0xffB5DE7F);
const Color orangeColor = const Color(0xffFFC729);
const Color redColor = const Color(0xffFF826E);

class DetailsPage extends StatefulWidget {
  DetailsPage({this.category});
  final Category category;
  @override
  _DetailsPageState createState() => new _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<Color> gradientColors = [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];

  List<PieChartSectionData> pieChartRawSections;
  List<PieChartSectionData> showingSections;

  StreamController<PieTouchResponse> pieTouchedResultStreamController;

  int touchedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final section1 = PieChartSectionData(
      color: redColor,
      value: 40,
      title: "40%",
      radius: 50,
      titleStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    );

    final section2 = PieChartSectionData(
      color: orangeColor,
      value: 30,
      title: "30%",
      radius: 50,
      titleStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    );

    final section3 = PieChartSectionData(
      color: greenColor,
      value: 30,
      title: "30%",
      radius: 50,
      titleStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    );


    final items = [
      section1,
      section2,
      section3,

    ];

    pieChartRawSections = items;

    showingSections = pieChartRawSections;

    pieTouchedResultStreamController = StreamController();
    pieTouchedResultStreamController.stream.distinct().listen((details) {
      print(details);
      if (details == null) {
        return;
      }

      touchedIndex = -1;
      if (details.sectionData != null) {
        touchedIndex = showingSections.indexOf(details.sectionData);
      }

      setState(() {
        if (details.touchInput is FlLongPressEnd) {
          touchedIndex = -1;
          showingSections = List.of(pieChartRawSections);
        } else {
          showingSections = List.of(pieChartRawSections);

          if (touchedIndex != -1) {
            final TextStyle style = showingSections[touchedIndex].titleStyle;
            showingSections[touchedIndex] =
                showingSections[touchedIndex].copyWith(
              titleStyle: style.copyWith(
                fontSize: 24,
              ),
              radius: 60,
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: new EdgeInsets.all(16),
        child: new ListView(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              child: new CircleAvatar(
                child: new Image.asset(widget.category.icon),
              ),
            ),
            new SizedBox(
              height: 16,
            ),
            new Text(
              widget.category.title,
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: redColor, fontWeight: FontWeight.bold, fontSize: 30),
            ),
            new SizedBox(
              height: 32,
            ),
            new Row(
              children: <Widget>[
                new Card(
                  color: greenColor,
                  elevation: 4,
                  child: new Container(
                    width: MediaQuery.of(context).size.width * 0.3 - 6,
                    padding: new EdgeInsets.all(16),
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          "24H",
                          style: new TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                        new SizedBox(
                          height: 16,
                        ),
                        new Text("30%")
                      ],
                    ),
                  ),
                ),
                new Card(
                  color: orangeColor,
                  elevation: 4,
                  child: new Container(
                    width: MediaQuery.of(context).size.width * 0.3 - 6,
                    padding: new EdgeInsets.all(16),
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          "7D",
                          style: new TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                        new SizedBox(
                          height: 16,
                        ),
                        new Text("43%")
                      ],
                    ),
                  ),
                ),
                new Card(
                  color: redColor,
                  elevation: 4,
                  child: new Container(
                    width: MediaQuery.of(context).size.width * 0.3 - 6,
                    padding: new EdgeInsets.all(16),
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          "30D",
                          style: new TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                        new SizedBox(
                          height: 16,
                        ),
                        new Text("35%")
                      ],
                    ),
                  ),
                )
              ],
            ),
            new SizedBox(
              height: 32,
            ),
            chartMiddle(),


            new Text("تفاصيل", textAlign: TextAlign.right, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            new Text(widget.category.info == null  ? " لا توجد معلومات حتى الآن": widget.category.info, textAlign: TextAlign.right,),
            AspectRatio(
              aspectRatio: 1,
              child: FlChart(
                chart: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(
                          touchResponseStreamSink:
                              pieTouchedResultStreamController.sink),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Indicator(
                  color: redColor,
                  text: "النوم",
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: orangeColor,
                  text: "التنقل",
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: greenColor,
                  text: "العمل",
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget chartMiddle() {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(
              right: 18.0, left: 12.0, top: 24, bottom: 12),
          child: FlChart(
            chart: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawHorizontalGrid: true,
                  getDrawingVerticalGridLine: (value) {
                    return const FlLine(
                      color: Color(0xff37434d),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingHorizontalGridLine: (value) {
                    return const FlLine(
                      color: Color(0xff37434d),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    textStyle: TextStyle(
                        color: const Color(0xff68737d),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 2:
                          return 'MAR';
                        case 5:
                          return 'JUN';
                        case 8:
                          return 'SEP';
                      }

                      return '';
                    },
                    margin: 8,
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    textStyle: TextStyle(
                      color: const Color(0xff67727d),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 1:
                          return '8h';
                        case 3:
                          return '16h';
                        case 5:
                          return '24h';
                      }
                      return '';
                    },
                    reservedSize: 28,
                    margin: 12,
                  ),
                ),
                borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Color(0xff37434d), width: 1)),
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 6,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 3),
                      FlSpot(2.6, 2),
                      FlSpot(4.9, 5),
                      FlSpot(6.8, 3.1),
                      FlSpot(8, 4),
                      FlSpot(9.5, 3),
                      FlSpot(11, 4),
                    ],
                    isCurved: true,
                    colors: gradientColors,
                    barWidth: 5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: false,
                    ),
                    belowBarData: BelowBarData(
                      show: true,
                      colors: gradientColors
                          .map((color) => color.withOpacity(0.3))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}
