import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:tutorial_coach_mark/src/target/target_focus.dart';

class TutorialController {
  double _paddingFocus = 6;
  Color colorShadow = Colors.transparent;
  double _opacityShadow = 0.1;
  bool isFinishOnSkip = false;
  ImageFilter? imageFilter = ImageFilter.blur(sigmaX: 8, sigmaY: 8);
  List<TargetFocus> _nextTargets = [];
  late void Function(List<TargetFocus> targets) _showTargets;

  void Function()? _onSkip;
  void Function()? _onFinish;
  void Function()? _onOverlayClick;
  void Function()? _finish;

  bool Function()? _isShowing;

  Function? get onSkip => _onSkip;
  Function? get onFinish => _onFinish;
  Function? get onOverlayClick => _onOverlayClick;
  bool get isShowing => _isShowing?.call() ?? false;
  double get paddingFocus => _paddingFocus;
  double get opacityShadow => _opacityShadow;

  init(
    Function(List<TargetFocus> targets) showTargets,
    bool Function() isShowing,
    Function() finish,
  ) {
    _showTargets = showTargets;
    _isShowing = isShowing;
    _finish = finish;
  }

  show(List<TargetFocus> targets, {bool? isFinishOnSkip}) {
    this.isFinishOnSkip = isFinishOnSkip ?? this.isFinishOnSkip;
    _showTargets.call(_getTargets(targets));
  }

  continueTutorial() {
    if (_nextTargets.isEmpty) return;
    show(_nextTargets);
  }

  List<TargetFocus> _getTargets(List<TargetFocus> targets) {
    _nextTargets = [];
    int foundIndex = -1;
    if (targets.length == 1) return targets;
    for (var i = 0; i < targets.length; i++) {
      if (targets[i].shouldStop) {
        foundIndex = i;
        break;
      }
    }
    if (foundIndex >= 0) {
      _nextTargets = targets.sublist(foundIndex + 1);
    }
    return targets.sublist(0, foundIndex + 1);
  }

  finish() {
    _finish?.call();
  }

  setPaddingFocus(double padding) {
    _paddingFocus = padding;
  }

  setOpacityShadow(double shadow) {
    _opacityShadow = shadow;
  }

  setColorShadow(Color colorShadow) {
    this.colorShadow = colorShadow;
  }

  setIsFinishOnSkip(bool value) {
    isFinishOnSkip = value;
  }

  setImageFilter(ImageFilter? imageFilter) {
    this.imageFilter = imageFilter;
  }

  setOnSkipListener(Function() onSkip) {
    _onSkip = onSkip;
  }

  setOnFinishListener(Function() onFinish) {
    _onFinish = onFinish;
  }

  setOnOverlayClickListener(Function() onOverlayClick) {
    _onOverlayClick = onOverlayClick;
  }

  removeOnSkipListener() {
    _onSkip = null;
  }

  removeOnFinishListener() {
    _onFinish = null;
  }

  removeOnOverlayClickListener() {
    _onOverlayClick = null;
  }

  dispose() {
    _onFinish = null;
    _onSkip = null;
    _onOverlayClick = null;
  }
}
