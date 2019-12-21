import 'package:hackai/src/core/bloc/base_bloc.dart';
import 'package:hackai/src/core/bloc/base_bloc_state.dart';
import 'package:hackai/src/core/bloc/content_loading_state.dart';
import 'package:hackai/src/core/bloc/error_state.dart';

class ProfileLoadedState extends BaseBlocState {}

class ProfileBloc extends BaseBloc<BaseBlocState, DoubleBlocState> {

  ProfileBloc(){
    getProfile();
  }

  @override
  DoubleBlocState get initialState =>
      DoubleBlocState(ContentLoadingState(), null);

  void getProfile() {
    Future.delayed(Duration(seconds: 2)).then((res) {
      add(ProfileLoadedState());
    }).catchError((err) {
      add(ErrorState(err));
    });
  }
}
