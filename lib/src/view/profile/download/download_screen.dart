import 'package:flutter/material.dart';
import 'package:hackai/res/values/styles.dart';
import 'package:hackai/src/core/bundle.dart';
import 'package:hackai/src/core/provider/vm_provider.dart';
import 'package:hackai/src/core/ui/base_statefull_screen.dart';
import 'package:hackai/src/core/ui/base_statefull_widget.dart';
import 'package:hackai/src/core/ui/ui_utils.dart';
import 'package:hackai/src/view/custom/BaseButton.dart';
import 'package:hackai/src/view/profile/download/category_chart.dart';
import 'package:hackai/src/view/profile/download/download_view_model.dart';
import 'package:hackai/src/view/upload/upload_view_model.dart';

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

  final DownloadViewModel __viewModel = DownloadViewModel();
  Category _category;

  @override
  Widget buildBody() {
    if (_category == null)
      _category = ((ModalRoute.of(context).settings.arguments as Bundle)
          .getDynamic("category") as Category);

    return VMProvider.withConsumer(
        viewModel: __viewModel,
        onModelReady: (_) {
          __viewModel.loadData(_category.text);
        },
        builder: (context, model, child) {
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
                          _category.ukrText,
                          style: getBigFont(),
                        ),
                      )
                    ],
                  ),
                ),
                __viewModel.contentProgress
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 32.0),
                            child: CategoryChart(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 32.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: RawMaterialButton(
                                    constraints: BoxConstraints(
                                        minWidth: double.infinity,
                                        minHeight: 50.0),
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
                                        minWidth: double.infinity,
                                        minHeight: 50.0),
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
                                      __viewModel.getJson();
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
              ],
            ),
          );
        });
  }
}
