import 'dart:convert';
import 'dart:io';

import 'package:hackai/src/core/bloc/base_bloc.dart';
import 'package:hackai/src/core/bloc/base_bloc_state.dart';
import 'package:hackai/src/core/bloc/content_loading_state.dart';
import 'package:hackai/src/data/repositories/ml/ml_repository.dart';
import 'package:hackai/src/di/dependency_injection.dart';
import 'package:path_provider/path_provider.dart';

class DownloadBloc extends BaseBloc<BaseBlocState, DoubleBlocState> {
  MLRepository _mlRepository;

  DownloadBloc() {
    _mlRepository = injector.get();
  }

  @override
  DoubleBlocState get initialState =>
      DoubleBlocState(ContentLoadingState(), null);

  Future<void> getJson(String text) async {
     _mlRepository.getCategory(text).then((value) async {
       var json = JsonEncoder().convert(value);
       final Directory directory = await getApplicationDocumentsDirectory();
       final File file = File('${directory.path}/json.txt');
       await file.writeAsString(json);
     });
  }
}
