import 'dart:io';
import 'dart:math';

class Bound {
  num? lower;
  num? upper;

  Bound(this.lower, this.upper) {}

  static Bound from(num number, [num nearest = 1]) {
    num min = number - nearest / 2;
    num max = number + nearest / 2;
    return new Bound(min, max);
  }

  Bound operator +(Bound that) {
    num min = this.lower! + that.lower!;
    num max = this.upper! + that.upper!;
    return new Bound(min, max);
  }

  Bound operator -(Bound that) {
    num min = this.lower! - that.upper!;
    num max = this.upper! - that.lower!;
    return new Bound(min, max);
  }

  Bound operator *(Bound that) {
    num min = this.lower! * that.lower!;
    num max = this.upper! * that.upper!;
    return new Bound(min, max);
  }

  Bound operator /(Bound that) {
    num min = this.lower! / that.upper!;
    num max = this.upper! / that.lower!;
    return new Bound(min, max);
  }

  Bound root() {
    num min = sqrt(this.lower!);
    num max = sqrt(this.upper!);
    return new Bound(min, max);
  }

  @override
  String toString() {
    return '${this.lower} <= this < ${this.upper}';
  }
}

void main(List<String> args) {
  // create bounds from the question
  Bound a = Bound.from(5.6, 1 / 10);
  Bound b = Bound.from(24.1, 1 / 10);
  Bound c = Bound.from(145);
  Bound d = Bound.from(0.34, 1 / 100);
  // show working by performing a single operation on bounds
  Bound x = a / b;
  print(x);
  Bound y = x.root();
  print(y);
  Bound z = c * d;
  print(z);
  Bound n = z - y;
  print(n);
}
