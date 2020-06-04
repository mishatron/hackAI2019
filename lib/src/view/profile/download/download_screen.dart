import 'package:flutter/material.dart';
import 'package:hackai/res/values/styles.dart';
import 'package:hackai/src/core/bundle.dart';
import 'package:hackai/src/core/ui/base_statefull_screen.dart';
import 'package:hackai/src/core/ui/base_statefull_widget.dart';
import 'package:hackai/src/core/ui/ui_utils.dart';
import 'package:hackai/src/view/custom/BaseButton.dart';
import 'package:hackai/src/view/profile/download/download_bloc.dart';

class DownloadScreen extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DownloadScreenState();
  }
}

class DownloadScreenState extends BaseStatefulScreen<DownloadScreen> {
  @override
  Widget buildAppbar() {
    return getAppBar(context, "Завантаження набору", leading: getBack());
  }

  DownloadBloc _bloc = DownloadBloc();

  @override
  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Row(
              children: <Widget>[
                Text(
                  "Категорія:",
                  style: getBigFont().merge(getBoldStyle()),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                      (ModalRoute.of(context).settings.arguments as Bundle)
                          .getString("category", defaultValue: ""), style: getBigFont(),),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RawMaterialButton(
                    constraints: BoxConstraints(
                        minWidth: double.infinity, minHeight: 50.0),
                    fillColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      "CSV",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: RawMaterialButton(
                    constraints: BoxConstraints(
                        minWidth: double.infinity, minHeight: 50.0),
                    fillColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      "JSON",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _bloc.getJson((ModalRoute.of(context).settings.arguments as Bundle)
                          .getString("category", defaultValue: ""));
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
