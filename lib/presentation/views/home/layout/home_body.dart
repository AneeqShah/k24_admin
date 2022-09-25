import 'package:flutter/material.dart';
import 'package:k24_admin/config/front_end_config.dart';
import 'package:k24_admin/presentation/elements/custom_text.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

int selectIndex = 1;

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 30,),
          // Container(
          //     child: SfCartesianChart(
          //       primaryYAxis: NumericAxis(
          //           minimum: 10,
          //           maximum: 50
          //       ),
          //       series: <ChartSeries<ChartData, int>>[
          //         ColumnSeries<ChartData, int>(
          //           color: FrontEndConfigs.kPrimaryColor,
          //             dataSource: chartData,
          //             xValueMapper: (ChartData data, _) => data.x,
          //             yValueMapper: (ChartData data, _) => data.y),
          //       ],
          //     )
          // )
        ],
      ),
    );
  }
  final List<ChartData> chartData = [
    ChartData(1, 24),
    ChartData(2, 25),
    ChartData(3, 28),
    ChartData(4, 35),
    ChartData(5, 23)
  ];
}
class ChartData{
  ChartData(this.x, this.y);
  final int x;
  final double y;
}