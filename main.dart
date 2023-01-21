import 'lib/volt.dart'; 

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