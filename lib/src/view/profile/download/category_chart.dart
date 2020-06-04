import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hackai/src/view/profile/download/download_view_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CategoryChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryChartState();
  }
}

class CategoryChartState extends State<CategoryChart> {
  @override
  Widget build(BuildContext context) {
    DownloadViewModel _viewModel = Provider.of<DownloadViewModel>(context);

    return AspectRatio(
      aspectRatio: 1,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _viewModel.chartMax,
          barTouchData: BarTouchData(
            enabled: false,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.transparent,
              tooltipPadding: const EdgeInsets.all(0),
              tooltipBottomMargin: 8,
              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                return BarTooltipItem(
                  rod.y.round().toString(),
                  TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              textStyle: TextStyle(
                  color: const Color(0xff7589a2),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
              margin: 20,
              getTitles: (double value) {
                int i = value.toInt();
                return DateFormat('dd.MM').format(_viewModel.points[i].date);
              },
            ),
            leftTitles: SideTitles(showTitles: true),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          gridData: FlGridData(drawHorizontalLine: true),
          barGroups: getBars(),
        ),
      ),
    );
  }

  List<BarChartGroupData> getBars() {
    DownloadViewModel _viewModel = Provider.of<DownloadViewModel>(context);
    List<BarChartGroupData> res = [];
    for (int i = 0; i < _viewModel.points.length; ++i) {
      res.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(
            y: _viewModel.points[i].count.toDouble(),
            color: Colors.lightBlueAccent)
      ], showingTooltipIndicators: [
        0
      ]));
    }
    return res;
  }
}
