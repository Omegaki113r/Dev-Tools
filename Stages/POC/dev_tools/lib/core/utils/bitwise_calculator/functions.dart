/*
 * Project: Xtronic Dev Tools
 * File Name: functions.dart
 * File Created: Saturday, 10th February 2024 3:33:04 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:30:11 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

int roundUp(int numToRound, int multiple) {
  if (multiple == 0) {
    return numToRound;
  }

  int remainder = numToRound % multiple;
  if (remainder == 0) {
    return numToRound;
  }

  return numToRound + multiple - remainder;
}
