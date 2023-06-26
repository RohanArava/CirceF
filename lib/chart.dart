import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class THChart extends StatelessWidget {
  const THChart(
      {super.key,
      required this.data});
  final List<int> data;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<int> ndata = data.where((element) => element!=0).toList();
    final List<int> fixedList = Iterable<int>.generate(ndata.length).toList();
    return SizedBox(
        width: size.width,
        height: size.height/2,
        child: LineChart(
          LineChartData(
              lineBarsData: [
                LineChartBarData(color: Colors.red,
                  spots: fixedList.map((point) => FlSpot(point.toDouble(), ndata[point].toDouble())).toList(),
                  isCurved: false,
                  dotData: FlDotData(
                    show: false,
                  ),
                ),
              ],borderData: FlBorderData(border: Border(left: BorderSide(color: Colors.white))),
            ),
        ),
          );
  }
}
