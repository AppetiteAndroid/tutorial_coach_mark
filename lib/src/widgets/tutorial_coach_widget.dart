import 'package:flutter/material.dart';

import 'tutorial_coach_mark_widget.dart';
import 'package:tutorial_coach_mark/src/target/target_focus.dart';

import 'tutorial_controller.dart';

class TutorialCoachWidget extends StatefulWidget {
  final Widget child;
  final TutorialController controller;
  const TutorialCoachWidget({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  @override
  State<TutorialCoachWidget> createState() => _TutorialCoachWidgetState();
}

class _TutorialCoachWidgetState extends State<TutorialCoachWidget> {
  final GlobalKey<TutorialCoachMarkWidgetState> _widgetKey = GlobalKey();
  Widget? _tutorialWidget;
  @override
  void initState() {
    widget.controller.init(_show, _isShowing, _finish);
    super.initState();
  }

  bool _isShowing() {
    return _tutorialWidget != null;
  }

  Future<void> _finish() async {
    if (_tutorialWidget == null) return;
    _tutorialWidget = null;
    widget.controller.onFinish?.call();
    setState(() {});
  }

  void _show(
    List<TargetFocus> targets,
  ) async {
    if (!mounted) return;
    Future.delayed(const Duration(milliseconds: 150)).then((value) {
      _tutorialWidget = TutorialCoachMarkWidget(
        targets: targets,
        key: _widgetKey,
        paddingFocus: widget.controller.paddingFocus,
        onClickSkip: _skip,
        hideSkip: true,
        colorShadow: widget.controller.colorShadow,
        opacityShadow: widget.controller.opacityShadow,
        pulseEnable: false,
        finish: _finish,
        imageFilter: widget.controller.imageFilter,
        clickOverlay: (p0) {
          widget.controller.onOverlayClick?.call();
        },
      );
      setState(() {});
    });
  }

  void _next() => _widgetKey.currentState?.next();

  void _previous() => _widgetKey.currentState?.previous();

  void _skip() {
    widget.controller.onSkip?.call();
    if (widget.controller.isFinishOnSkip) {
      _finish();
    } else {
      _next();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_tutorialWidget != null)
          WillPopScope(
            child: const SizedBox(),
            onWillPop: () async {
              if (_isShowing()) {
                _finish();
                return false;
              }
              return true;
            },
          ),
        Positioned.fill(child: widget.child),
        if (_tutorialWidget != null)
          Positioned.fill(
            child: _tutorialWidget!,
          ),
      ],
    );
  }
}
