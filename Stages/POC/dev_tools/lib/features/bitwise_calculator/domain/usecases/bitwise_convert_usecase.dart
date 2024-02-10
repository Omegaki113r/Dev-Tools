import 'package:dev_tools/core/utils/bitwise_calculator/functions.dart';
import 'package:dev_tools/core/utils/bitwise_calculator/lexer.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/entities/bitwise_converter_entity.dart';

class BitwiseConvert {
  BitwiseConverterEntity convertFromDecimal(String text) {
    String binaryText = "";
    String octalText = "";
    String hexText = "";
    String decimal2sComplimentText = "";
    String decimalText = "";
    Lexer lexer = Lexer(text);

    Token? token = lexer.getToken();
    while (token != null &&
        token.token != TokenType.eof &&
        token.token != TokenType.newline) {
      if (token.token == TokenType.number) {
        BigInt? parsed = BigInt.tryParse(token.tokenText, radix: 10);
        if (parsed != null) {
          binaryText += parsed.toRadixString(2);
          octalText += parsed.toRadixString(8);
          hexText += parsed.toRadixString(16).toUpperCase();
          int roundedUpTo = roundUp(parsed.bitLength, 8);
          if (roundedUpTo > 64) {
            roundedUpTo = roundUp(roundedUpTo, 64);
          }
          if (roundedUpTo > 32) {
            roundedUpTo = roundUp(roundedUpTo, 32);
          }
          if (roundedUpTo > 16) {
            roundedUpTo = roundUp(roundedUpTo, 16);
          }
          if (roundedUpTo == 0) {
            roundedUpTo = 8;
          }
          decimal2sComplimentText += (parsed.toSigned(roundedUpTo) < BigInt.zero
              ? "${parsed.toSigned(roundedUpTo)} "
              : "N/A ");
        }
      } else {
        binaryText += token.tokenText;
        octalText += token.tokenText;
        hexText += token.tokenText;
      }
      token = lexer.getToken();
    }
    decimalText = text;
    return BitwiseConverterEntity(
        hexText, decimalText, decimal2sComplimentText, binaryText, octalText);
  }

  BitwiseConverterEntity convertFromBinary(String text) {
    String binaryText = "";
    String octalText = "";
    String hexText = "";
    String decimal2sComplimentText = "";
    String decimalText = "";
    Lexer lexer = Lexer(text);

    Token? token = lexer.getToken();
    while (token != null &&
        token.token != TokenType.eof &&
        token.token != TokenType.newline) {
      if (token.token == TokenType.number) {
        BigInt? parsed = BigInt.tryParse(token.tokenText, radix: 2);
        if (parsed != null) {
          octalText += parsed.toRadixString(8);
          decimalText += parsed.toRadixString(10);
          hexText += parsed.toRadixString(16).toUpperCase();
          int roundedUpTo = roundUp(parsed.bitLength, 8);
          if (roundedUpTo > 64) {
            roundedUpTo = roundUp(roundedUpTo, 64);
          }
          if (roundedUpTo > 32) {
            roundedUpTo = roundUp(roundedUpTo, 32);
          }
          if (roundedUpTo > 16) {
            roundedUpTo = roundUp(roundedUpTo, 16);
          }
          if (roundedUpTo == 0) {
            roundedUpTo = 8;
          }
          decimal2sComplimentText = (parsed.toSigned(roundedUpTo) < BigInt.zero
              ? "${parsed.toSigned(roundedUpTo)} "
              : "N/A ");
        }
      } else {
        decimalText += token.tokenText;
        octalText += token.tokenText;
        hexText += token.tokenText;
      }
      token = lexer.getToken();
    }
    binaryText = text;
    return BitwiseConverterEntity(
        hexText, decimalText, decimal2sComplimentText, binaryText, octalText);
  }

  BitwiseConverterEntity convertFromOctal(String text) {
    String binaryText = "";
    String octalText = "";
    String hexText = "";
    String decimal2sComplimentText = "";
    String decimalText = "";
    Lexer lexer = Lexer(text);

    Token? token = lexer.getToken();
    while (token != null &&
        token.token != TokenType.eof &&
        token.token != TokenType.newline) {
      if (token.token == TokenType.number) {
        BigInt? parsed = BigInt.tryParse(token.tokenText, radix: 8);
        if (parsed != null) {
          binaryText += parsed.toRadixString(2);
          decimalText += parsed.toRadixString(10);
          hexText += parsed.toRadixString(16).toUpperCase();
          int roundedUpTo = roundUp(parsed.bitLength, 8);
          if (roundedUpTo > 64) {
            roundedUpTo = roundUp(roundedUpTo, 64);
          }
          if (roundedUpTo > 32) {
            roundedUpTo = roundUp(roundedUpTo, 32);
          }
          if (roundedUpTo > 16) {
            roundedUpTo = roundUp(roundedUpTo, 16);
          }
          if (roundedUpTo == 0) {
            roundedUpTo = 8;
          }
          decimal2sComplimentText = (parsed.toSigned(roundedUpTo) < BigInt.zero
              ? "${parsed.toSigned(roundedUpTo)} "
              : "N/A ");
        }
      } else {
        decimalText += token.tokenText;
        binaryText += token.tokenText;
        hexText += token.tokenText;
      }
      token = lexer.getToken();
    }
    octalText = text;
    return BitwiseConverterEntity(
        hexText, decimalText, decimal2sComplimentText, binaryText, octalText);
  }

  BitwiseConverterEntity convertFromHex(String text) {
    String binaryText = "";
    String octalText = "";
    String hexText = "";
    String decimal2sComplimentText = "";
    String decimalText = "";
    Lexer lexer = Lexer(text);

    Token? token = lexer.getToken();

    while (token != null &&
        token.token != TokenType.eof &&
        token.token != TokenType.newline) {
      if (token.token == TokenType.number) {
        BigInt? parsed = BigInt.tryParse(token.tokenText, radix: 16);
        if (parsed != null) {
          binaryText += parsed.toRadixString(2);
          octalText += parsed.toRadixString(8);
          decimalText += parsed.toRadixString(10);
          int roundedUpTo = roundUp(parsed.bitLength, 8);
          if (roundedUpTo > 64) {
            roundedUpTo = roundUp(roundedUpTo, 64);
          }
          if (roundedUpTo > 32) {
            roundedUpTo = roundUp(roundedUpTo, 32);
          }
          if (roundedUpTo > 16) {
            roundedUpTo = roundUp(roundedUpTo, 16);
          }
          if (roundedUpTo == 0) {
            roundedUpTo = 8;
          }
          decimal2sComplimentText += (parsed.toSigned(roundedUpTo) < BigInt.zero
              ? "${parsed.toSigned(roundedUpTo)} "
              : "N/A ");
        }
      } else {
        binaryText += token.tokenText;
        octalText += token.tokenText;
        decimalText += token.tokenText;
      }
      token = lexer.getToken();
    }
    hexText = text;

    return BitwiseConverterEntity(
        hexText, decimalText, decimal2sComplimentText, binaryText, octalText);
  }
}
