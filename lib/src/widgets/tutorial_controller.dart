import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:tutorial_coach_mark/src/target/target_focus.dart';

class TutorialController {
  double _paddingFocus = 6;
  Color colorShadow = Colors.transparent;
  double _opacityShadow = 0.1;
  bool isFinishOnSkip = false;
  ImageFilter? imageFilter = ImageFilter.blur(sigmaX: 8, sigmaY: 8);

  late void Function(List<TargetFocus> targets) _showTargets;

  void Function()? _onSkip;
  void Function()? _onFinish;
  void Function()? _onOverlayClick;

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
  ) {
    _showTargets = showTargets;
    _isShowing = isShowing;
  }

  show(List<TargetFocus> targets, {bool? isFinishOnSkip}) {
    this.isFinishOnSkip = isFinishOnSkip ?? this.isFinishOnSkip;
    _showTargets.call(targets);
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
