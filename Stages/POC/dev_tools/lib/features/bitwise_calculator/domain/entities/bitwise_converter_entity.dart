class BitwiseConverterEntity {
  final String hex;
  final String decimal;
  final String decimal2sCompliment;
  final String binary;
  final String octal;
  BitwiseConverterEntity(
    this.hex,
    this.decimal,
    this.decimal2sCompliment,
    this.binary,
    this.octal,
  );

  BitwiseConverterEntity.empty()
      : hex = "",
        decimal = "",
        decimal2sCompliment = "",
        binary = "",
        octal = "";
}
