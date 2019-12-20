import 'package:hackai/router/route_paths.dart';
import 'package:hackai/src/core/bloc/base_bloc.dart';
import 'package:hackai/src/core/bloc/base_bloc_state.dart';
import 'package:hackai/src/core/bloc/empty_bloc_state.dart';
import 'package:hackai/src/core/bloc/error_state.dart';
import 'package:hackai/src/di/dependency_injection.dart';

abstract class SplashState extends BaseBlocState {}

class SplashRouteState extends SplashState {
  final String routeName;

  SplashRouteState(this.routeName);
}

class SplashBloc extends BaseBloc<BaseBlocState, DoubleBlocState> {

  SplashBloc() {
    getUserIsLoggedIn();
  }

  @override
  DoubleBlocState get initialState => DoubleBlocState(EmptyBlocState(), null);

  void getUserIsLoggedIn() {
    add((SplashRouteState(mainRoute)));
  }
}
