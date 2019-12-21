import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackai/router/route_paths.dart';
import 'package:hackai/src/core/bloc/base_bloc.dart';
import 'package:hackai/src/core/bloc/base_bloc_state.dart';
import 'package:hackai/src/core/bloc/empty_bloc_state.dart';

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
//       FirebaseAuth.instance.currentUser().then((user) {
//      if (user != null)
//        add((SplashRouteState(mainRoute)));
//      else
//        add((SplashRouteState(loginRoute)));
//    }).catchError((err) {
//      add((SplashRouteState(loginRoute)));
//    });

  }
}
