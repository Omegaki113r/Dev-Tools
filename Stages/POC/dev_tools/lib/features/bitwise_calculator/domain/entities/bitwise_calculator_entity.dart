class BitwiseCalculatorModel {
  String focusedText = "";
  String hexText = "";
  String decimalText = "";
  String decimal2sComplimentText = "";
  String binaryText = "";
  String octalText = "";
  BitwiseCalculatorModel(this.focusedText, this.hexText, this.decimalText,
      this.decimal2sComplimentText, this.binaryText, this.octalText);

  static int roundUp(int numToRound, int multiple) {
    if (multiple == 0) {
      return numToRound;
    }

    int remainder = numToRound % multiple;
    if (remainder == 0) {
      return numToRound;
    }

    return numToRound + multiple - remainder;
  }
}
