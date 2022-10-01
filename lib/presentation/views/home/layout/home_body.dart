import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:k24_admin/config/front_end_config.dart';
import 'package:k24_admin/presentation/elements/custom_text.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

int selectIndex = 1;

class _HomeBodyState extends State<HomeBody> {
  List<DocumentSnapshot> allPickups = [];
  final List<DeveloperSeries> data = [];
  int monday = 0;
  int tuesday = 0;
  int wednesday = 0;
  int thursday = 0;
  int friday = 0;
  int saturday = 0;
  int sunday = 0;

  //Months
  int January = 0;
  int February = 0;
  int March = 0;
  int April = 0;
  int May = 0;
  int June = 0;
  int July = 0;
  int August = 0;
  int September = 0;
  int October = 0;
  int November = 0;
  int December = 0;

  @override
  void initState() {
    // TODO: implement initState
    _getGraphData();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DeveloperSeries, String>> series = [
      charts.Series(
          id: "developers",
          data: data,
          domainFn: (DeveloperSeries series, _) => series.year,
          measureFn: (DeveloperSeries series, _) => series.developers,
          colorFn: (DeveloperSeries series, _) => series.barColor)
    ];
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Welcome to',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  Image.asset('assets/images/logo2.png'),
                ],
              ),
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/dp.png'),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      _getGraphData();
                      setState(() {
                        selectIndex = 1;
                      });
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: selectIndex == 1
                              ? FrontEndConfigs.kPrimaryColor
                              : Colors.transparent),
                      child: Center(
                          child: CustomText(
                        text: '7 Days',
                        fontSize: 13,
                        color: selectIndex == 1 ? Colors.white : Colors.black,
                      )),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      _getMonthGraph();
                      setState(() {
                        selectIndex = 2;
                      });
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: selectIndex == 2
                              ? FrontEndConfigs.kPrimaryColor
                              : Colors.transparent),
                      child: Center(
                          child: CustomText(
                        text: '30 Days',
                        fontSize: 13,
                        color: selectIndex == 2 ? Colors.white : Colors.black,
                      )),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      _getYearData();
                      setState(() {
                        selectIndex = 3;
                      });
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: selectIndex == 3
                              ? FrontEndConfigs.kPrimaryColor
                              : Colors.transparent),
                      child: Center(
                          child: CustomText(
                        text: '12 Months',
                        fontSize: 13,
                        color: selectIndex == 3 ? Colors.white : Colors.black,
                      )),
                    ),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              height: MediaQuery.of(context).size.height * .4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
                boxShadow:  [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                child: charts.BarChart(
                  series,
                  animate: true,
                  primaryMeasureAxis: const charts.NumericAxisSpec(
                      renderSpec: charts.GridlineRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                        fontSize: 10,
                        color: charts.MaterialPalette
                            .black), //chnage white color as per your requirement.
                  )),
                  domainAxis: const charts.OrdinalAxisSpec(
                      showAxisLine: true,
                      renderSpec: charts.GridlineRendererSpec(
                        lineStyle: charts.LineStyleSpec(
                          thickness: 0,
                          color: charts.MaterialPalette.transparent,
                        ),
                        labelStyle: charts.TextStyleSpec(
                            fontSize: 8,
                            color: charts.MaterialPalette
                                .black), //chnage white color as per your requirement.
                      )),
                ),
              )),
        ],
      ),
    );
  }

  _getGraphData() {
    int previousTime =
        Jiffy().subtract(days: 7).dateTime.millisecondsSinceEpoch;
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    FirebaseFirestore.instance
        .collection("order")
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      monday = 0;
      tuesday = 0;
      wednesday = 0;
      saturday = 0;
      sunday = 0;
      thursday = 0;
      friday = 0;
      data.clear();
      setState(() {});
      for (var element in snapshot.docs) {
        int date = element["orderTime"];
        if (date >= previousTime && date <= currentTime) {
          var dt = DateTime.fromMillisecondsSinceEpoch(element['orderTime']);
          String formattedDate = Jiffy(dt).format("EEEE"); // Tuesday
          if (formattedDate == "Monday") {
            int num = int.parse(element["price"]);
            monday = monday + num;
          } else if (formattedDate == "Tuesday") {
            int num = int.parse(element["price"]);
            tuesday = tuesday + num;
          } else if (formattedDate == "Wednesday") {
            int num = int.parse(element["price"]);
            wednesday = wednesday + num;
          } else if (formattedDate == "Thursday") {
            int num = int.parse(element["price"]);
            thursday = thursday + num;
          } else if (formattedDate == "Friday") {
            int num = int.parse(element["price"]);
            friday = friday + num;
          } else if (formattedDate == "Saturday") {
            int num = int.parse(element["price"]);
            saturday = saturday + num;
          } else {
            int num = int.parse(element["price"]);
            sunday = sunday + num;
          }
          setState(() {});
        } else {}
      }

      data.add(DeveloperSeries(
          year: "Mo",
          developers: monday,
          barColor:
              charts.ColorUtil.fromDartColor(FrontEndConfigs.kPrimaryColor)));

      data.add(DeveloperSeries(
          year: "Tu",
          developers: tuesday,
          barColor: charts.ColorUtil.fromDartColor(FrontEndConfigs.newColor)));

      data.add(DeveloperSeries(
          year: "We",
          developers: wednesday,
          barColor:
              charts.ColorUtil.fromDartColor(FrontEndConfigs.kPrimaryColor)));

      data.add(DeveloperSeries(
          year: "Th",
          developers: thursday,
          barColor: charts.ColorUtil.fromDartColor(FrontEndConfigs.newColor)));

      data.add(DeveloperSeries(
          year: "Fr",
          developers: friday,
          barColor:
              charts.ColorUtil.fromDartColor(FrontEndConfigs.kPrimaryColor)));

      data.add(DeveloperSeries(
          year: "Sa",
          developers: saturday,
          barColor: charts.ColorUtil.fromDartColor(FrontEndConfigs.newColor)));

      data.add(DeveloperSeries(
          year: "Su",
          developers: sunday,
          barColor:
              charts.ColorUtil.fromDartColor(FrontEndConfigs.kPrimaryColor)));
      setState(() {});
    });
  }

  _getMonthGraph() async {
    List<DateTime> listdays = [];
    monday = 0;
    tuesday = 0;
    wednesday = 0;
    saturday = 0;
    sunday = 0;
    thursday = 0;
    friday = 0;
    data.clear();

    setState(() {});
    DateTime start = DateTime.now().subtract(const Duration(days: 30));
    for (int i = 0; i <= 30; i++) {
      listdays.add(start.add(Duration(days: i)));
    }
    FirebaseFirestore.instance
        .collection("order")
        .where("orderTime", isGreaterThan: listdays[0].millisecondsSinceEpoch)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        var dt = DateTime.fromMillisecondsSinceEpoch(element['orderTime']);
        String formattedDate = Jiffy(dt).format("dd MMM");
        String day = Jiffy(dt).format("MMM");
        data.add(DeveloperSeries(
            year: formattedDate.replaceAll(day, ""),
            developers: int.parse(element['price']),
            barColor:
                charts.ColorUtil.fromDartColor(FrontEndConfigs.kPrimaryColor)));
      });

      setState(() {});
    });
  }

  _getYearData() {
    int previousTime =
        Jiffy().subtract(days: 360).dateTime.millisecondsSinceEpoch;
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    FirebaseFirestore.instance
        .collection("order")
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      January = 0;
      February = 0;
      March = 0;
      April = 0;
      May = 0;
      June = 0;
      July = 0;
      August = 0;
      September = 0;
      October = 0;
      November = 0;
      December = 0;
      data.clear();

      setState(() {});
      for (var element in snapshot.docs) {
        int date = element["orderTime"];
        if (date >= previousTime && date <= currentTime) {
          var dt = DateTime.fromMillisecondsSinceEpoch(element['orderTime']);
          String formattedDate = Jiffy(dt).format("MMMM"); // Tuesday
          if (formattedDate == "January") {
            int num = int.parse(element["price"]);
            January = January + num;
          } else if (formattedDate == "February") {
            int num = int.parse(element["price"]);
            February = February + num;
          } else if (formattedDate == "March") {
            int num = int.parse(element["price"]);
            March = March + num;
          } else if (formattedDate == "April") {
            int num = int.parse(element["price"]);
            April = April + num;
          } else if (formattedDate == "May") {
            int num = int.parse(element["price"]);
            May = May + num;
          } else if (formattedDate == "June") {
            int num = int.parse(element["price"]);
            June = June + num;
          } else if (formattedDate == "July") {
            int num = int.parse(element["price"]);
            July = July + num;
          } else if (formattedDate == "August") {
            int num = int.parse(element["price"]);
            August = August + num;
          } else if (formattedDate == "September") {
            int num = int.parse(element["price"]);
            September = September + num;
          } else if (formattedDate == "November") {
            int num = int.parse(element["price"]);
            November = November + num;
          } else if (formattedDate == "December") {
            int num = int.parse(element["price"]);
            December = December + num;
          }
          setState(() {});
        } else {}
      }

      data.add(DeveloperSeries(
          year: "Jan",
          developers: January,
          barColor:
              charts.ColorUtil.fromDartColor(FrontEndConfigs.kPrimaryColor)));

      data.add(DeveloperSeries(
          year: "Feb",
          developers: February,
          barColor: charts.ColorUtil.fromDartColor(FrontEndConfigs.newColor)));

      data.add(DeveloperSeries(
          year: "Mar",
          developers: March,
          barColor:
              charts.ColorUtil.fromDartColor(FrontEndConfigs.kPrimaryColor)));

      data.add(DeveloperSeries(
          year: "Apr",
          developers: April,
          barColor: charts.ColorUtil.fromDartColor(FrontEndConfigs.newColor)));

      data.add(DeveloperSeries(
          year: "May",
          developers: May,
          barColor:
              charts.ColorUtil.fromDartColor(FrontEndConfigs.kPrimaryColor)));

      data.add(DeveloperSeries(
          year: "Jun",
          developers: June,
          barColor: charts.ColorUtil.fromDartColor(FrontEndConfigs.newColor)));

      data.add(DeveloperSeries(
          year: "Jul",
          developers: July,
          barColor:
              charts.ColorUtil.fromDartColor(FrontEndConfigs.kPrimaryColor)));
      data.add(DeveloperSeries(
          year: "Aug",
          developers: August,
          barColor: charts.ColorUtil.fromDartColor(FrontEndConfigs.newColor)));
      data.add(DeveloperSeries(
          year: "Sep",
          developers: September,
          barColor:
              charts.ColorUtil.fromDartColor(FrontEndConfigs.kPrimaryColor)));
      data.add(DeveloperSeries(
          year: "Oct",
          developers: October,
          barColor: charts.ColorUtil.fromDartColor(FrontEndConfigs.newColor)));
      data.add(DeveloperSeries(
          year: "Nov",
          developers: November,
          barColor:
              charts.ColorUtil.fromDartColor(FrontEndConfigs.kPrimaryColor)));
      data.add(DeveloperSeries(
          year: "Dec",
          developers: December,
          barColor: charts.ColorUtil.fromDartColor(FrontEndConfigs.newColor)));
      setState(() {});
    });
  }
}

class DeveloperSeries {
  final String year;
  final int developers;
  final charts.Color barColor;

  DeveloperSeries(
      {required this.year, required this.developers, required this.barColor});
}
