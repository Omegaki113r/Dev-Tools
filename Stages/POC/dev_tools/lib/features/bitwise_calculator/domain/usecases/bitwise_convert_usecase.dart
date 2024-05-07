/*
 * Project: Xtronic Dev Tools
 * File Name: bitwise_convert_usecase.dart
 * File Created: Saturday, 10th February 2024 11:07:05 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:31:03 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'dart:convert';

import 'package:b/b.dart';
import 'package:dev_tools/core/utils/bitwise_calculator/functions.dart';
import 'package:dev_tools/core/utils/bitwise_calculator/lexer.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/entities/bitwise_converter_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BitwiseConvert {
  BitwiseConverterEntity convertFromDecimal(String text) {
    String binaryText = "";
    String octalText = "";
    String hexText = "";
    String decimal2sComplimentText = "";
    String decimalText = "";
    String asciiText = "";
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
          try {
            asciiText += String.fromCharCode(parsed.toInt());
          } on RangeError {
            asciiText = "N/A";
          }
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
      } else if (token.token == TokenType.floatNumber) {
        ByteData data = ByteData(8);
        data.setFloat64(0, double.tryParse(token.tokenText)!);
        BaseConversion binaryConversion =
            BaseConversion(from: base10, to: base2);
        BaseConversion octalConversion =
            BaseConversion(from: base10, to: base8);
        BaseConversion hexConversion = BaseConversion(from: base10, to: base16);
        binaryText += binaryConversion(token.tokenText);
        hexText += hexConversion(token.tokenText).toUpperCase();
        octalText += octalConversion(token.tokenText);
        if (kDebugMode) {
          print(binaryConversion(token.tokenText));
          print(octalConversion(token.tokenText));
          print(hexConversion(token.tokenText));
        }
      } else {
        binaryText += token.tokenText;
        octalText += token.tokenText;
        hexText += token.tokenText;
        if (token.tokenText != " ") {
          asciiText += token.tokenText;
        }
      }
      token = lexer.getToken();
    }
    decimalText = text;
    return BitwiseConverterEntity(hexText, decimalText, decimal2sComplimentText,
        binaryText, octalText, asciiText);
  }

  BitwiseConverterEntity convertFromBinary(String text) {
    String binaryText = "";
    String octalText = "";
    String hexText = "";
    String decimal2sComplimentText = "";
    String decimalText = "";
    String asciiText = "";
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
          try {
            asciiText += String.fromCharCode(parsed.toInt());
          } on RangeError {
            asciiText = "N/A";
          }
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
        if (token.tokenText != " ") {
          asciiText += token.tokenText;
        }
      }
      token = lexer.getToken();
    }
    binaryText = text;
    return BitwiseConverterEntity(hexText, decimalText, decimal2sComplimentText,
        binaryText, octalText, asciiText);
  }

  BitwiseConverterEntity convertFromOctal(String text) {
    String binaryText = "";
    String octalText = "";
    String hexText = "";
    String decimal2sComplimentText = "";
    String decimalText = "";
    String asciiText = "";
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
          try {
            asciiText += String.fromCharCode(parsed.toInt());
          } on RangeError {
            asciiText = "N/A";
          }
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
        if (token.tokenText != " ") {
          asciiText += token.tokenText;
        }
      }
      token = lexer.getToken();
    }
    octalText = text;
    return BitwiseConverterEntity(hexText, decimalText, decimal2sComplimentText,
        binaryText, octalText, asciiText);
  }

  BitwiseConverterEntity convertFromHex(String text) {
    String binaryText = "";
    String octalText = "";
    String hexText = "";
    String decimal2sComplimentText = "";
    String decimalText = "";
    String asciiText = "";
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
          try {
            asciiText += String.fromCharCode(parsed.toInt());
          } on RangeError {
            asciiText = "N/A";
          }
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
        if (token.tokenText != " ") {
          asciiText += token.tokenText;
        }
      }
      token = lexer.getToken();
    }
    hexText = text;

    return BitwiseConverterEntity(hexText, decimalText, decimal2sComplimentText,
        binaryText, octalText, asciiText);
  }

  BitwiseConverterEntity convertFromAscii(String text) {
    String binaryText = "";
    String octalText = "";
    String hexText = "";
    String decimal2sComplimentText = "";
    String decimalText = "";
    String asciiText = "";
    AsciiEncoder asciiEncoder = const AsciiEncoder();

    for (var character in text.characters) {
      // if (isAlphanumeric(character)) {
      Uint8List charList = asciiEncoder.convert(character);
      if (kDebugMode) {
        print(charList);
      }
      binaryText += "${charList[0].toRadixString(2)} ";
      octalText += "${charList[0].toRadixString(8)} ";
      decimalText += "${charList[0].toRadixString(10)} ";
      hexText += "${charList[0].toRadixString(16)} ";

      int roundedUpTo = roundUp(charList[0].bitLength, 8);
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
      decimal2sComplimentText +=
          (BigInt.from(charList[0]).toSigned(roundedUpTo) < BigInt.zero
              ? "${BigInt.from(charList[0]).toSigned(roundedUpTo)} "
              : "N/A ");
      // } else {
      //   binaryText += "$character ";
      //   octalText += "$character ";
      //   decimalText += "$character ";
      //   hexText += "$character ";
      // }
    }

    // Lexer lexer = Lexer(text);
    // Token? token = lexer.getToken();

    // while (token != null &&
    //     token.token != TokenType.eof &&
    //     token.token != TokenType.newline) {
    //   if (token.token == TokenType.number) {
    //     Uint8List charList = asciiEncoder.convert(token.tokenText);
    //     for (var char in charList) {
    //       BigInt? parsed = BigInt.from(char);
    //       if (parsed != null) {
    //         binaryText += parsed.toRadixString(2);
    //         octalText += parsed.toRadixString(8);
    //         decimalText += parsed.toRadixString(10);
    //         hexText += parsed.toRadixString(16);
    //         int roundedUpTo = roundUp(parsed.bitLength, 8);
    //         if (roundedUpTo > 64) {
    //           roundedUpTo = roundUp(roundedUpTo, 64);
    //         }
    //         if (roundedUpTo > 32) {
    //           roundedUpTo = roundUp(roundedUpTo, 32);
    //         }
    //         if (roundedUpTo > 16) {
    //           roundedUpTo = roundUp(roundedUpTo, 16);
    //         }
    //         if (roundedUpTo == 0) {
    //           roundedUpTo = 8;
    //         }
    //         decimal2sComplimentText +=
    //             (parsed.toSigned(roundedUpTo) < BigInt.zero
    //                 ? "${parsed.toSigned(roundedUpTo)} "
    //                 : "N/A ");
    //       }
    //     }
    //   } else {
    //     binaryText += token.tokenText;
    //     octalText += token.tokenText;
    //     decimalText += token.tokenText;
    //     hexText += token.tokenText;
    //   }
    //   token = lexer.getToken();
    // }
    asciiText = text;

    return BitwiseConverterEntity(hexText, decimalText, decimal2sComplimentText,
        binaryText, octalText, asciiText);
  }
}
