//3.
class Calculator {
  // Store calculation history
  final List<String> _history = [];

  // Basic arithmetic operations
  double add(double a, double b) {
    final result = a + b;
    _addToHistory('$a + $b = $result');
    return result;
  }

  double subtract(double a, double b) {
    final result = a - b;
    _addToHistory('$a - $b = $result');
    return result;
  }

  double multiply(double a, double b) {
    final result = a * b;
    _addToHistory('$a × $b = $result');
    return result;
  }

  double? divide(double a, double b) {
    if (b == 0) {
      _addToHistory('$a ÷ $b = Error: Division by zero');
      return null;
    }
    final result = a / b;
    _addToHistory('$a ÷ $b = $result');
    return result;
  }

  // Multi-step calculation handler
  double? calculate(String expression) {
    try {
      // Remove spaces and validate input
      expression = expression.replaceAll(' ', '');
      if (!RegExp(r'^[0-9+\-*/().]+$').hasMatch(expression)) {
        throw FormatException('Invalid characters in expression');
      }

      // Handle parentheses first
      while (expression.contains('(')) {
        final openIndex = expression.lastIndexOf('(');
        final closeIndex = expression.indexOf(')', openIndex);
        if (closeIndex == -1) throw FormatException('Mismatched parentheses');

        final subExpression = expression.substring(openIndex + 1, closeIndex);
        final subResult = calculate(subExpression);
        if (subResult == null) return null;

        expression = expression.replaceRange(
            openIndex, closeIndex + 1, subResult.toString());
      }

      // Handle multiplication and division first
      while (expression.contains(RegExp(r'[*/]'))) {
        final match =
            RegExp(r'(\d+\.?\d*)[/](\d+\.?\d)').firstMatch(expression);
        if (match == null) throw FormatException('Invalid expression');

        final a = double.parse(match.group(1)!);
        final b = double.parse(match.group(2)!);
        final op = expression[match.start + match.group(1)!.length];

        double? result;
        if (op == '*') {
          result = multiply(a, b);
        } else {
          result = divide(a, b);
          if (result == null) return null;
        }

        expression =
            expression.replaceRange(match.start, match.end, result.toString());
      }

      // Handle addition and subtraction
      while (expression.contains(RegExp(r'[+\-]'))) {
        final match =
            RegExp(r'(\d+\.?\d*)[+\-](\d+\.?\d*)').firstMatch(expression);
        if (match == null) throw FormatException('Invalid expression');

        final a = double.parse(match.group(1)!);
        final b = double.parse(match.group(2)!);
        final op = expression[match.start + match.group(1)!.length];

        final result = op == '+' ? add(a, b) : subtract(a, b);

        expression =
            expression.replaceRange(match.start, match.end, result.toString());
      }

      final result = double.parse(expression);
      _addToHistory('Final result: $result');
      return result;
    } catch (e) {
      _addToHistory('Error: ${e.toString()}');
      return null;
    }
  }

  // History management
  void _addToHistory(String entry) {
    _history.add(entry);
  }

  List<String> getHistory() {
    return List.from(_history);
  }

  void clearHistory() {
    _history.clear();
  }
}

void main() {
  final calculator = Calculator();

  // Basic operations
  print(calculator.add(5, 3)); // 8.0
  print(calculator.subtract(10, 4)); // 6.0
  print(calculator.multiply(6, 7)); // 42.0
  print(calculator.divide(15, 3)); // 5.0
  print(calculator.divide(10, 0)); // null (division by zero)

  // Multi-step calculations
  print(calculator.calculate('2 + 3 * 4')); // 14.0
  print(calculator.calculate('(2 + 3) * 4')); // 20.0
  print(calculator.calculate('10 / (2 + 3)')); // 2.0
  print(calculator.calculate('10 / (2 - 2)')); // null (division by zero)

  // Print calculation history
  print('\nCalculation History:');
  calculator.getHistory().forEach(print);
}
