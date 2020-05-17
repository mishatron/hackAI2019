import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackai/res/values/styles.dart';
import 'package:hackai/src/core/provider/vm_provider.dart';
import 'package:hackai/src/core/ui/base_statefull_screen.dart';
import 'package:hackai/src/core/ui/base_statefull_widget.dart';
import 'package:hackai/src/core/ui/ui_utils.dart';
import 'package:hackai/src/view/custom/BaseButton.dart';
import 'package:hackai/src/view/upload/upload_view_model.dart';

class UploadScreen extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadScreenState();
  }
}

class _UploadScreenState extends BaseStatefulScreen<UploadScreen> {
  final UploadViewModel _viewModel = UploadViewModel();

  @override
  Widget buildAppbar() {
    return getAppBar(context, "Покращи світовий датасет");
  }

  Widget getLabelsList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _viewModel.currentLabels.length,
        itemBuilder: (context, index) {
          return Text(_viewModel.currentLabels[index].label);
        });
  }

  @override
  Widget buildBody() {
    return VMProvider<UploadViewModel>.withConsumer(
        viewModel: _viewModel,
        builder: (context, model, child) {
          if (_viewModel.image == null) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(64.0),
                  child: Image.asset("assets/add_photo.png"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: BaseButton(
                    text: "Перевірити об'єкт",
                    onClick: _viewModel.check,
                  ),
                )
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Завантажене фото",
                    style: getMidFontBold(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: AspectRatio(
                        aspectRatio: 3 / 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.file(
                            _viewModel.image,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                  _viewModel.location != null
                      ? Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.add_location,
                                color: Colors.red,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  "Локація",
                                  style: getMidFontBold(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "${_viewModel.location.latitude}, ${_viewModel.location.longitude} ",
                                  style: getMidFont(),
                                ),
                              ),

                            ],
                          ),
                      )
                      : const Offstage(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: _viewModel.currentLabels != null
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Результат:", style: getMidFontBold(),),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: getLabelsList(),
                            ),
                          ],
                        )
                        : const Offstage(),
                  )
                ],
              ),
            );
          }
        });
  }
}
