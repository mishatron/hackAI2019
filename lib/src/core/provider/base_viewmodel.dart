import 'dart:async';

import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  StreamController<Object> errorsController = StreamController();
  StreamController<bool> progressController = StreamController();
  StreamController<String> msgResController = StreamController();
  StreamController<String> msgController = StreamController();
  bool _contentProgress = false;

  bool get contentProgress => _contentProgress;

  void _setContentProgress(bool value) {
    _contentProgress = value;
    notifyListeners();
  }

  @protected
  void showContentProgress() {
    _setContentProgress(true);
  }

  @protected
  void hideContentProgress() {
    _setContentProgress(false);
  }

  @protected
  void showProgress() {
    progressController.add(true);
  }

  @protected
  void hideProgress() {
    progressController.add(false);
  }

  @protected
  void handleError(Object err) {
    if (_contentProgress) _setContentProgress(false);
    errorsController.add(err);
  }

  @protected
  void showMessageRes(String msgRes) {
    if (msgRes == null) return;
    msgResController.add(msgRes);
  }

  @protected
  void showMessage(String msg) {
    if (msg == null) return;
    msgController.add(msg);
  }

  @override
  void dispose() {
    errorsController.close();
    progressController.close();
    msgController.close();
    msgResController.close();
    super.dispose();
  }
}
