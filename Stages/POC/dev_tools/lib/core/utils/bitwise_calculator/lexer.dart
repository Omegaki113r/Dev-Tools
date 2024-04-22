/*
 * Project: Xtronic Dev Tools
 * File Name: lexer.dart
 * File Created: Tuesday, 16th January 2024 5:03:21 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:30:13 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:flutter/foundation.dart';

class Lexer {
  String source;
  String currentCharacter;
  int currentPosition;
  Lexer(this.source)
      : currentCharacter = "",
        currentPosition = -1 {
    source += "\n";
    nextChar();
  }

  void nextChar() {
    ++currentPosition;
    if (currentPosition >= source.length) {
      currentCharacter = "";
    } else {
      currentCharacter = source[currentPosition];
    }
  }

  String peek() {
    if (currentPosition + 1 >= source.length) {
      return "";
    }
    return source[currentPosition + 1];
  }

  void abort(String message) {
    if (kDebugMode) {
      print("Lexing Error. $message");
    }
  }

  void skipWhiteSpace() {
    while (currentCharacter == " " ||
        currentCharacter == "\t" ||
        currentCharacter == "\r") {
      nextChar();
    }
  }

  Token? getToken() {
    // skipWhiteSpace();
    Token? token;
    if (currentCharacter == " ") {
      token = Token(currentCharacter, TokenType.space);
    } else if (currentCharacter == "+") {
      token = Token(currentCharacter, TokenType.add);
    } else if (currentCharacter == "-") {
      token = Token(currentCharacter, TokenType.sub);
    } else if (currentCharacter == "*") {
      token = Token(currentCharacter, TokenType.mul);
    } else if (currentCharacter == "/") {
      token = Token(currentCharacter, TokenType.div);
    } else if (currentCharacter == "\n") {
      token = Token(currentCharacter, TokenType.newline);
    } else if (currentCharacter == "<") {
      if (peek() == "<") {
        String lastCharacter = currentCharacter;
        nextChar();
        token = Token(lastCharacter + currentCharacter, TokenType.shiftL);
      }
    } else if (currentCharacter == ">") {
      if (peek() == ">") {
        String lastCharacter = currentCharacter;
        nextChar();
        token = Token(lastCharacter + currentCharacter, TokenType.shiftR);
      }
    } else if (currentCharacter == "&") {
      token = Token(currentCharacter, TokenType.and);
    } else if (currentCharacter == "|") {
      token = Token(currentCharacter, TokenType.or);
    } else if (currentCharacter == "^") {
      token = Token(currentCharacter, TokenType.xor);
    } else if (isDigit(currentCharacter, 0) ||
        isValidCharacter(currentCharacter)) {
      int startPosition = currentPosition;
      while (isDigit(peek(), 0) || isValidCharacter(peek())) {
        nextChar();
      }
      if (peek() == ".") {
        nextChar();
        if (!isDigit(peek(), 0) && !isValidCharacter(peek())) {
          abort("Illegal character in number");
        }
        while (isDigit(peek(), 0) || isValidCharacter(peek())) {
          nextChar();
        }
      }
      String tokenText = source.substring(startPosition, currentPosition + 1);
      token = Token(tokenText, TokenType.number);
    } else if (currentCharacter == "(") {
      token = Token("(", TokenType.leftParan);
    } else if (currentCharacter == ")") {
      token = Token(")", TokenType.rightParan);
    } else if (currentCharacter == "") {
      token = Token("", TokenType.eof);
    } else {
      abort("Unknown token: $currentCharacter");
    }
    nextChar();
    return token;
  }

  bool isDigit(String s, int idx) {
    if (s.isEmpty) {
      return false;
    }
    return (s.codeUnitAt(idx) ^ 0x30) <= 9;
  }

  bool isValidCharacter(String s) =>
      s == "F" ||
      s == "f" ||
      s == "E" ||
      s == "e" ||
      s == "D" ||
      s == "d" ||
      s == "C" ||
      s == "c" ||
      s == "B" ||
      s == "b" ||
      s == "A" ||
      s == "a";
}

class Token {
  String tokenText;
  TokenType token;
  Token(this.tokenText, this.token);
}

enum TokenType {
  eof,
  newline,
  space,
  number,
  asciiString,
  add,
  sub,
  mul,
  div,
  shiftL,
  shiftR,
  and,
  or,
  xor,
  leftParan,
  rightParan,
}
