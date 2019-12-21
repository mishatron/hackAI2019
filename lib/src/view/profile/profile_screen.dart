import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackai/res/values/styles.dart';
import 'package:hackai/src/core/bloc/base_bloc_listener.dart';
import 'package:hackai/src/core/bloc/base_bloc_state.dart';
import 'package:hackai/src/core/bloc/content_loading_state.dart';
import 'package:hackai/src/core/ui/base_statefull_screen.dart';
import 'package:hackai/src/core/ui/base_statefull_widget.dart';
import 'package:hackai/src/core/ui/ui_utils.dart';
import 'package:hackai/src/view/profile/ProfileBloc.dart';
import 'package:hackai/src/view/utils/image_utils.dart';

class ProfileScreen extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends BaseStatefulScreen<ProfileScreen>
    with BaseBlocListener {
  ProfileBloc _bloc = ProfileBloc();

  @override
  Widget buildAppbar() {
    return null;
  }

  @override
  Widget buildBody() {
    return  BlocProvider(
      builder: (context) => _bloc,
      child: BlocListener(
        bloc: _bloc,
        listener: blocListener,
        child: BlocBuilder<ProfileBloc, DoubleBlocState>(
          builder: (context, state) {
            if (state.lastSuccessState is ContentLoadingState) {
              return getProgress(background: false);
            } else if(state.lastSuccessState is ProfileLoadedState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      getUserAvatar("", 80),
                      Text("Імя Прізвище", style: getBigFont(),),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: <Widget>[
                              Icon(Icons.email),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("email@qq.com", style:  getMidFont(),),
                              )
                            ],),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: <Widget>[
                              Icon(Icons.phone_android),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("+380954150177", style:  getMidFont(),),
                              )
                            ],),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: <Widget>[
                              Icon(Icons.exit_to_app),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Вийти", style:  getMidFont(),),
                              )
                            ],),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            else return Offstage();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
