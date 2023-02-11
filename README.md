# Dart

A utility library made with Replit!

## Installation

```sh
dart pub add volt
```

After installing the package, import the `lib/volt.dart` file. 

```dart
import 'package:volt/volt.dart';
```

## Features

### Detailed Pretty Printing

The `String format(dynamic entity)` function turns `List`, `LinkedHashMap`, and other `Object` types into **readable** strings. 

```dart
class Test {
  int id = 0;
  static const original = 0;
  static void greet(String name) {
    print('Hello, $name!');
  }
}

void main() {
  print(format({ "id": 0, "items": ["app", "ban"], "test": new Test() }));
}
```

The console will output the text below with details like the length of the list, keys, and properties. 

```dart
LinkedHashMap (3) {
  "id": 0,
  "items": List (2) [
    "app",
    "ban"
  ],
  "test": Test (4) {
    int id;
    static const final int original;
    static void greet => static void greet(String name) {
      print('Hello, $name!');
    };
    Test Test => null;
  }
}
```