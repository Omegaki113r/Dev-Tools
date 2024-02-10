class BitwiseSolverEntity {
  final String hex;
  final String decimal;
  final String binary;
  final String octal;
  BitwiseSolverEntity(
    this.hex,
    this.decimal,
    this.binary,
    this.octal,
  );

  BitwiseSolverEntity.empty()
      : hex = "",
        decimal = "",
        binary = "",
        octal = "";
}
