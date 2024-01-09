import 'package:dev_tools/const/app_colors.dart';
import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';

enum ButtonType{FLAT,CONCAVE,CONVEX,EMBOSS}

class SidebarButton extends StatelessWidget {
  final String label;
  final double height;
  final ButtonType buttonType;
  final Function onPressed;
  const SidebarButton(this.label, this.height,this.buttonType,
      {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
        left: 20.0,
        right: 30.0,
      ),
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: switch (buttonType) {
          ButtonType.FLAT => FlatSidebarButton(label, height),
          ButtonType.CONCAVE => ConcaveSidebarButton(label, height),
          ButtonType.CONVEX => ConvexSidebarButton(label, height),
          ButtonType.EMBOSS => EmbossSidebarButton(label, height),
        }
        // child: ConcaveSidebarButton(label, height),
        // child: ConvexSidebarButton(label, height),
        // child: EmbossSidebarButton(label, height),
      ),
    );
  }
}

// class SidebarButton extends StatefulWidget {
//   SidebarButton(this.label, this.height, {super.key, required this.onPressed});

//   @override
//   State<SidebarButton> createState() => _SidebarButtonState();
// }

// class _SidebarButtonState extends State<SidebarButton> {
//   bool _isPressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         top: 20.0,
//         bottom: 20.0,
//         left: 20.0,
//         right: 30.0,
//       ),
//       child: TextButton(
//         onPressed: () {
//           widget.onPressed();
//         },
//         // child: FlatSidebarButton(widget.label, widget.height),
//         // child: ConcaveSidebarButton(widget.label, widget.height),
//         // child: ConvexSidebarButton(widget.label, widget.height),
//         child: EmbossSidebarButton(widget.label, widget.height),
//       ),
//     );
//   }
// }

class FlatSidebarButton extends StatelessWidget {
  final String label;
  final double height;
  const FlatSidebarButton(this.label, this.height, {super.key});

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
            color: Color(0xFF312C5E),
          ),
          BoxShadow(
            offset: Offset(10, 10),
            blurRadius: 20,
            color: Color(0xFF050227),
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

class ConcaveSidebarButton extends StatelessWidget {
  final String label;
  final double height;
  const ConcaveSidebarButton(this.label, this.height, {super.key});

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

class ConvexSidebarButton extends StatelessWidget {
  final String label;
  final double height;
  const ConvexSidebarButton(this.label, this.height, {super.key});

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

class EmbossSidebarButton extends StatelessWidget {
  final String label;
  final double height;
  const EmbossSidebarButton(this.label, this.height, {super.key});

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

class LibNeumorphic extends StatelessWidget {
  final String label;
  final double height;
  const LibNeumorphic(this.label, this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
