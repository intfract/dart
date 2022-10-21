import 'dart:math' as math;

bool bi(int x) {
  if (x > 0) {
    return true;
  } else {
    return false;
  }
}

extension Utility on List {
  dynamic nth(int index) {
    return this[(this.length + index) % this.length];
  }
}

class Polynomial {
  List coeffs = [];
  Polynomial(this.coeffs) {}

  num constant() {
    return coeffs.nth(0);
  }

  num leading() {
    return coeffs.nth(-1);
  }

  Polynomial tangent(num x) {
    num slope = coeffs.nth(1);
    num intercept = this.constant();
    for (int i = 2; i < coeffs.length; i++) {
      slope += i * coeffs[i] * math.pow(x, i - 1);
      intercept -= (i - 1) * coeffs[i] * math.pow(x, i);
    }
    return new Polynomial([intercept, slope]);
  }

  String toString() {
    String s = '';
    for (int i = 0; i < coeffs.length; i++) {
      if (bi(i)) {
        s += ' + (${coeffs[i]}x^(${i}))';
      } else {
        s += '${coeffs[i]}';
      }
    }
    return s;
  }
}

void main() {
  Polynomial equation = new Polynomial([1, -2, 1]);
  print(equation.toString());
  print(equation.tangent(2).toString());
}
