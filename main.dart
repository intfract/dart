import 'dart:math' as math;

bool eq(dynamic x, dynamic y) {
  if (x.runtimeType != y.runtimeType) return false;
  
  if (x is List && y is List) {
    if (x.length != y.length) return false;
    for (int i = 0; i < x.length; i++) {
      bool b = eq(x[i], y[i]);
      if (!b) return false;
    }
    return true;
  }
  
  if (x is Map && y is Map) {
    if (x.length != y.length) return false;
    for (String k in x.keys) {
      bool b = eq(x[k], y[k]);
      if (!b) return false;
    }
    return true;
  }
  
  return x == y;
}

extension MapMethods on Map {
  bool matches(Map that) {
    for (String k in that.keys) {
      if (!eq(this[k], that[k])) return false;
    }
    return true;
  }
}

extension ListMethods on List {
  dynamic nth(int index) {
    return this[(this.length + index) % this.length];
  }

  List<List> filter(Function funnel) {
    List filtrate = [];
    List residue = [];
    for (int i = 0; i < this.length; i++) {
      if (funnel(this[i], i)) {
        filtrate.add(this[i]);
      } else {
        residue.add(this[i]);
      }
    }
    return [filtrate, residue];
  }

  List<List<Map<String, dynamic>>> filterMaps(dynamic funnel) {
    List<Map<String, dynamic>> filtrate = [];
    List<Map<String, dynamic>> residue = [];
    if (funnel is String) {
      for (int i = 0; i < this.length; i++) {
        if (this[i][funnel]) {
          filtrate.add(this[i]);
        } else {
          residue.add(this[i]);
        }
      }
    } else if (funnel is List && funnel.length == 2) {
      for (int i = 0; i < this.length; i++) {
        if (this[i][funnel[0]] == funnel[1]) {
          filtrate.add(this[i]);
        } else {
          residue.add(this[i]);
        }
      }
    } else if (funnel is Map) {
      for (int i = 0; i < this.length; i++) {
        if (this[i].matches(funnel)) {
          filtrate.add(this[i]);
        } else {
          residue.add(this[i]);
        }
      }
    } else {
      throw('InvalidFunnelError');
    }
    return [filtrate, residue];
  }
}

bool boolean(int x) {
  return x > 0 ? true : false;
}

int integer(bool x) {
  return x ? 1 : 0;
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
      if (boolean(i)) {
        s += ' + (${coeffs[i]}x^(${i}))';
      } else {
        s += '${coeffs[i]}';
      }
    }
    return s;
  }
}

void main() {
  print(eq([0, '', [], {}], [0, '', [], {}]));
  print(eq({ 'a': [] }, { 'a': [] }));
  
  print([0, 1, 2, 3].filter((item, int index) { return item > 1; }));
  List users = [
    { 'name': 'John', 'age': 18, 'active': true },
    { 'name': 'Jane', 'age': 13, 'active': true },
    { 'name': 'Jeff', 'age': 69, 'active': false },
  ];
  print(users.filterMaps('active'));
  print(users.filterMaps(['name', 'Jane']));
  print(users.filterMaps({ 'active': false }));
}
