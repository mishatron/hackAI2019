import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:hackai/src/core/provider/base_viewmodel.dart';
import 'package:hackai/src/data/repositories/ml/ml_repository.dart';
import 'package:hackai/src/di/dependency_injection.dart';
import 'package:hackai/src/domain/data_model.dart';
import 'package:path_provider/path_provider.dart';

class BarPoint {
  final DateTime date;
  final int count;

  BarPoint(this.date, this.count);
}

class DownloadViewModel extends BaseViewModel {
  final MLRepository _mlRepository = injector.get();

  String text;
  List<DataModel> data;
  Map<DateTime, List<DataModel>> grouped = Map();
  List<BarPoint> points = [];

  double chartMax = 0.0;

  void loadData(String text) async {
    this.text = text;
    showContentProgress();
    try {
      data = await _mlRepository.getCategory(text);
      _prepareChartData();
      hideContentProgress();
    } catch (err) {
      hideContentProgress();
      handleError(err);
    }
  }

  void _prepareChartData() {
    chartMax = 0.0;
    grouped.clear();
    points.clear();
    for (int i = 0; i < data.length; ++i) {
      DateTime parsed = DateTime.fromMillisecondsSinceEpoch(data[i].timestamp);
      DateTime key = DateTime(parsed.year, parsed.month, parsed.day);
      if (grouped.containsKey(key))
        grouped[key].add(data[i]);
      else
        grouped[key] = [data[i]];
    }
    grouped.forEach((key, value) {
      chartMax = max(chartMax, value.length.toDouble());
    });
    chartMax += 5.0;

    grouped.forEach((key, value) {
      points.add(BarPoint(key, value.length));
    });
    points.sort((a, b) {
      return a.date.compareTo(b.date);
    });

    notifyListeners();
  }

  Future<void> getJson() async {
    var json = JsonEncoder().convert(data);
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File(
        '${directory.path}/$text\_${DateTime.now().millisecondsSinceEpoch}.json');
    await file.writeAsString(json);
    final params = SaveFileDialogParams(sourceFilePath: file.path);
    final filePath = await FlutterFileDialog.saveFile(params: params);
  }
}
