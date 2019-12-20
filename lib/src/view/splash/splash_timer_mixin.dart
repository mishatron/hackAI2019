import 'dart:async';

import 'package:hackai/router/navigation_service.dart';
import 'package:hackai/src/core/ui/base_state.dart';
import 'package:hackai/src/core/ui/base_statefull_widget.dart';
import 'package:hackai/src/di/dependency_injection.dart';

mixin SplashTimerMixin<T extends BaseStatefulWidget> on BaseState<T> {
  int _curTime = 0;
  final int _secondsBeforeStop = 2;
  String nextRoute = "";

  startTimeout() async {
    var duration = const Duration(seconds: 1);
    return Timer.periodic(duration, _handleTimeout);
  }

  void _handleTimeout(Timer timer) {
    _curTime++;
    if (nextRoute.isNotEmpty && _curTime > _secondsBeforeStop) {
      injector<NavigationService>().pushNamedReplacement(nextRoute);
      timer.cancel();
    }
  }
}
