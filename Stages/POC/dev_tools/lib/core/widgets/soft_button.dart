/*
 * Project: Xtronic Dev Tools
 * File Name: soft_button.dart
 * File Created: Thursday, 11th January 2024 7:52:00 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:30:19 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

enum ButtonState {
  defaultState,
  pressedState,
}

class SoftButton extends StatefulWidget {
  final String label;
  final double? height;
  final double? width;
  final ButtonType buttonType;
  final Function onPressed;
  final EdgeInsetsGeometry? padding;
  final ButtonState _buttonState;
  final Duration duration = const Duration(seconds: 2);
  const SoftButton(this.label, this.buttonType,
      {super.key,
      this.padding,
      this.height,
      this.width,
      required this.onPressed})
      : _buttonState = ButtonState.defaultState;

  @override
  State<SoftButton> createState() => _SoftButtonState();
}

class _SoftButtonState extends State<SoftButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          widget.padding != null ? widget.padding! : const EdgeInsets.all(0),
      child: GestureDetector(
        // onTap: () => onPressed(),
        onTapUp: (details) {
          // setState(() {
          //   widget._buttonState = ButtonState.DEFAULT;
          // });
        },
        onTapDown: (details) {
          widget.onPressed();
          setState(() {
            // widget._buttonState = ButtonState.PRESSED;
          });
        },
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          // child: AnimatedSwitcher(
          //   duration: Duration(milliseconds: 5),
          //   transitionBuilder: (child, animation) {
          //     return ScaleTransition(
          //       scale: animation,
          //       child: child,
          //     );
          //   },
          //   child: widget._buttonState == ButtonState.DEFAULT
          //       ? FlatSoftButton(widget.label)
          //       : ConvexSoftButton(widget.label),
          // ),
          child: switch (widget._buttonState) {
            ButtonState.defaultState => FlatSoftButton(widget.label),
            ButtonState.pressedState => ConvexSoftButton(widget.label),
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SoftButton oldWidget) {
    _animationController.duration = widget.duration;
    super.didUpdateWidget(oldWidget);
  }
}

class FlatSoftButton extends StatelessWidget {
  final String label;
  // final double height;
  const FlatSoftButton(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: const BoxDecoration(
        // color: color6,
        gradient: LinearGradient(colors: [
          color6,
          color6,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: Offset(-5, -5),
            blurRadius: 10,
            color: Color(0xFF312C5E),
          ),
          BoxShadow(
            offset: Offset(5, 5),
            blurRadius: 10,
            color: Color(0xFF050227),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}

class ConcaveSoftButton extends StatelessWidget {
  final String label;
  const ConcaveSoftButton(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        // color: color6,
        gradient: LinearGradient(colors: [
          Color(0xFF0F0B2F),
          Color(0xFF2C2754),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: Offset(-10, -10),
            blurRadius: 20,
            color: Color(0xFF312C5E),
          ),
          BoxShadow(
            offset: Offset(10, 10),
            blurRadius: 20,
            color: Color(0xFF050227),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}

class ConvexSoftButton extends StatelessWidget {
  final String label;
  const ConvexSoftButton(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        // color: color6,
        gradient: LinearGradient(colors: [
          Color(0xFF2C2754),
          Color(0xFF0F0B2F),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: Offset(-10, -10),
            blurRadius: 20,
            color: Color(0xFF312C5E),
          ),
          BoxShadow(
            offset: Offset(10, 10),
            blurRadius: 20,
            color: Color(0xFF050227),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}

class EmbossSoftButton extends StatelessWidget {
  final String label;
  final double height;
  const EmbossSoftButton(this.label, this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: color6,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: Offset(-10, -10),
            blurRadius: 20,
            spreadRadius: -10,
            color: Color(0xFF312C5E),
            inset: true,
          ),
          BoxShadow(
            offset: Offset(10, 10),
            blurRadius: 20,
            spreadRadius: -10,
            color: Color(0xFF050227),
            inset: true,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: height,
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }
}
