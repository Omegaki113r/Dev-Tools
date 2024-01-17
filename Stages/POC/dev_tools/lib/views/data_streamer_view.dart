import 'package:dev_tools/const/app_constants.dart';
import 'package:dev_tools/const/app_strings.dart';
import 'package:dev_tools/widgets/soft_button.dart';
import 'package:dev_tools/widgets/soft_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DataStreamerView extends StatelessWidget {
  const DataStreamerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                SoftButton(
                  LBL_CONNECT,
                  ButtonType.FLAT,
                  width: 150,
                  height: 45,
                  onPressed: () {
                    print("state changed");
                  },
                ),
                Gap(20),
                SoftDropDown(
                  width: 185,
                  height: 45,
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
