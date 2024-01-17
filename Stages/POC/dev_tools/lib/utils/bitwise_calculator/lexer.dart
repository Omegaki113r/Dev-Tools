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
      currentCharacter = "\0";
    } else {
      currentCharacter = source[currentPosition];
    }
  }

  String peek() {
    if (currentPosition + 1 >= source.length) {
      return "\0";
    }
    return source[currentPosition + 1];
  }

  void abort(String message) {
    print("Lexing Error. " + message);
  }

  void skipWhiteSpace() {
    while (currentCharacter == " " ||
        currentCharacter == "\t" ||
        currentCharacter == "\r") {
      nextChar();
    }
  }

  Token? getToken() {
    skipWhiteSpace();
    Token? token;
    if (currentCharacter == "+") {
      token = Token(currentCharacter, TokenType.ADD);
    } else if (currentCharacter == "-") {
      token = Token(currentCharacter, TokenType.SUB);
    } else if (currentCharacter == "*") {
      token = Token(currentCharacter, TokenType.MUL);
    } else if (currentCharacter == "/") {
      token = Token(currentCharacter, TokenType.DIV);
    } else if (currentCharacter == "\n") {
      token = Token(currentCharacter, TokenType.NEWLINE);
    } else if (currentCharacter == "\0") {
      token = Token(currentCharacter, TokenType.EOF);
    } else if (currentCharacter == "<") {
      if (peek() == "<") {
        String lastCharacter = currentCharacter;
        nextChar();
        token = Token(lastCharacter + currentCharacter, TokenType.SHIFT_L);
      }
    } else if (currentCharacter == ">") {
      if (peek() == ">") {
        String lastCharacter = currentCharacter;
        nextChar();
        token = Token(lastCharacter + currentCharacter, TokenType.SHIFT_R);
      }
    } else if (currentCharacter == "&") {
      token = Token(currentCharacter, TokenType.AND);
    } else if (currentCharacter == "|") {
      token = Token(currentCharacter, TokenType.OR);
    } else if (currentCharacter == "^") {
      token = Token(currentCharacter, TokenType.XOR);
    } else if (isDigit(currentCharacter, 0)) {
      int startPosition = currentPosition;
      while (isDigit(peek(), 0)) {
        nextChar();
      }
      if (peek() == ".") {
        nextChar();
        if (!isDigit(peek(), 0)) {
          abort("Illegal character in number");
        }
        while (isDigit(peek(), 0)) {
          nextChar();
        }
      }
      String tokenText = source.substring(startPosition, currentPosition + 1);
      token = Token(tokenText, TokenType.NUMBER);
    } else {
      abort("Unknown token: " + currentCharacter);
    }
    nextChar();
    return token;
  }

  bool isDigit(String s, int idx) => (s.codeUnitAt(idx) ^ 0x30) <= 9;
}

class Token {
  String tokenText;
  TokenType token;
  Token(this.tokenText, this.token);
}

enum TokenType {
  EOF,
  NEWLINE,
  SPACE,
  NUMBER,
  ADD,
  SUB,
  MUL,
  DIV,
  SHIFT_L,
  SHIFT_R,
  AND,
  OR,
  XOR,
}
