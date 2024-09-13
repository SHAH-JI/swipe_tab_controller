library swipe_tab_controller;

import 'package:flutter/material.dart';

class SwipeTabController extends StatefulWidget {
  const SwipeTabController({
    required this.onTabChanged,
    required this.child,
    super.key,
  });

  ///Called when the tab is changed, pass your tab change logic into this function
  final ValueChanged<int> onTabChanged;

  ///The child widget
  final Widget child;

  @override
  State<SwipeTabController> createState() => _SwipeTabControllerState();
}

class _SwipeTabControllerState extends State<SwipeTabController> {
  TabController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final TabController? defaultTabController = DefaultTabController.maybeOf(context);

    assert(() {
      if (defaultTabController == null) {
        throw FlutterError(
          'No DefaultTabController for ${widget.runtimeType}.\n'
          'When creating a ${widget.runtimeType}, you must ensure that there '
          'is a DefaultTabController above the ${widget.runtimeType}.',
        );
      }
      return true;
    }());

    if (defaultTabController != _controller) {
      _controller?.removeListener(_listener);
      _controller = defaultTabController;
      _controller?.animation?.addListener(_listener);
    }
  }

  void _listener() {
    final TabController? controller = _controller;
    widget.onTabChanged(controller!.indexIsChanging ? controller.index : controller.animation!.value.round());
  }

  @override
  void dispose() {
    _controller?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
