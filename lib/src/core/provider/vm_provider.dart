import 'package:flutter/material.dart';
import 'package:hackai/src/core/provider/base_viewmodel.dart';
import 'package:hackai/src/core/ui/base_state.dart';
import 'package:hackai/src/core/ui/base_statefull_widget.dart';
import 'package:provider/provider.dart';

enum _VMProviderType { WithoutConsumer, WithConsumer }

/// A widget that provides base functionality for the Mvvm style provider architecture by FilledStacks.
class VMProvider<T extends BaseViewModel> extends BaseStatefulWidget {
  final Widget staticChild;
  final Function(T) onModelReady;
  final Widget Function(BuildContext, T, Widget) builder;
  final T viewModel;
  final _VMProviderType providerType;

  VMProvider.withoutConsumer({
    @required this.builder,
    @required this.viewModel,
    this.onModelReady,
  })  : providerType = _VMProviderType.WithoutConsumer,
        staticChild = null;

  VMProvider.withConsumer({
    @required this.viewModel,
    @required this.builder,
    this.staticChild,
    this.onModelReady,
  }) : providerType = _VMProviderType.WithConsumer;

  @override
  _VMProviderState<T> createState() => _VMProviderState<T>();
}

class _VMProviderState<T extends BaseViewModel>
    extends BaseState<VMProvider<T>> {
  T _model;

  @override
  void initState() {
    super.initState();
    _model = widget.viewModel;
    if (widget.onModelReady != null) {
      widget.onModelReady(_model);
    }
    _model.errorsController.stream.listen((data) {
      onError(data);
    });
    _model.progressController.stream.listen((bool data) {
      if (data)
        showProgress();
      else
        hideProgress();
    });
    _model.msgResController.stream.listen((String msgRes) {
      onShowMessage(msgRes);
    });
    _model.msgController.stream.listen((String msg) {
      showMessage(msg);
    });
  }

  @override
  Widget getLayout() {
    if (widget.providerType == _VMProviderType.WithoutConsumer) {
      return ChangeNotifierProvider(
        create: (context) => _model,
        child: widget.builder(context, _model, null),
      );
    }

    return ChangeNotifierProvider.value(
        value: _model,
        child: Consumer<T>(
          builder: widget.builder,
          child: widget.staticChild,
        ));
  }
}
