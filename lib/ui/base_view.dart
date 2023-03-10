import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/locator.dart';

class BaseStatelessView<T extends ChangeNotifier> extends StatelessWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;

  BaseStatelessView({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final T _model = locator<T>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => _model, child: Consumer<T>(builder: builder));
  }
}

class BaseStatefulView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;

  final Function(T)? loadOnInit;

  const BaseStatefulView(
      {Key? key, required this.builder, required this.loadOnInit})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BaseStatefulViewState<T> createState() => _BaseStatefulViewState<T>();
}

class _BaseStatefulViewState<T extends ChangeNotifier>
    extends State<BaseStatefulView<T>> {
  final T _model = locator<T>();
  @override
  void initState() {
    if (widget.loadOnInit != null) {
      widget.loadOnInit!(_model);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => _model,
        child: Consumer<T>(builder: widget.builder));
  }
}
