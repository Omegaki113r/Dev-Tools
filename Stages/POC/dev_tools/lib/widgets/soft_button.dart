import 'package:dev_tools/const/app_colors.dart';
import 'package:dev_tools/const/app_constants.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

enum ButtonState {
  DEFAULT,
  PRESSED,
}

class SoftButton extends StatefulWidget {
  final String label;
  final double? height;
  final double? width;
  final ButtonType buttonType;
  final Function onPressed;
  EdgeInsetsGeometry? padding;
  ButtonState _buttonState = ButtonState.DEFAULT;
  final Duration duration = Duration(seconds: 2);
  SoftButton(this.label, this.buttonType,
      {super.key,
      this.padding,
      this.height,
      this.width,
      required this.onPressed});

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
            widget._buttonState = ButtonState.PRESSED;
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
            ButtonState.DEFAULT => FlatSoftButton(widget.label),
            ButtonState.PRESSED => ConvexSoftButton(widget.label),
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
      width: double.infinity,
      decoration: const BoxDecoration(
        // color: color6,
        gradient: LinearGradient(colors: [
          color6,
          color6,
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
