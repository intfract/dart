import 'dart:collection';
import 'dart:mirrors';

bool isContainer(data) {
  return data is List || data is LinkedHashMap || data is Object;
}

String format(entity, [indent = 0]) {
  String tab = '  ';
  if (entity is List) {
    List items = [];
    for (int i = 0; i < entity.length; i++) {
      items.add('${tab * (indent + 1)}${isContainer(entity[i]) ? format(entity[i], indent + 1) : format(entity[i])}');
    }
    return 'List (${items.length}) [\n${items.join(',\n')}\n${tab * indent}]';
  }
  if (entity is String) {
    return '"$entity"';
  }
  if (entity is num) {
    return '$entity';
  }
  if (entity is LinkedHashMap) {
    List<String> pairs = [];
    for (String k in entity.keys) {
      pairs.add('${tab * (indent + 1)}${format(k)}: ${isContainer(entity[k]) ? format(entity[k], indent + 1) : format(entity[k])}');
    }
    return 'LinkedHashMap (${entity.keys.length}) {\n${pairs.join(',\n')}\n${tab * indent}}';
  }
  if (entity is Object) {
    List<String> pairs = [];
    RegExp exp = RegExp(r"(?!')[A-z]+(?=')");
    
    InstanceMirror instanceMirror = reflect(entity);
    var classMirror = instanceMirror.type;

    for (var v in classMirror.declarations.values) {
      var name = MirrorSystem.getName(v.simpleName);

      if (v is VariableMirror) {
        pairs.add(
          '${tab * (indent + 1)}${(v.isPrivate) ? 'private ' : ''}${(v.isStatic) ? 'static ' : ''}${(v.isConst) ? 'const ' : ''}${(v.isFinal) ? 'final ' : ''}${exp.firstMatch(v.type.toString())![0]} $name;'
        );
      } else if (v is MethodMirror) {
        pairs.add(
          '${tab * (indent + 1)}${(v.isPrivate) ? 'private ' : ''}${(v.isStatic) ? 'static' : ''}${(v.isAbstract) ? 'abstract ' : ''}${exp.firstMatch(v.returnType.toString())![0]} $name => ${v.source?.replaceAll('\n', '\n${tab * indent}')};'
        );
      }
    }

    return '${entity.runtimeType} (${pairs.length}) {\n${pairs.join('\n')}\n${tab * indent}}';
  }
  return entity.toString();
}

String log(entity) {
  String message = format(entity);
  print(message);
  return message;
}

num round(num n, [num to = 1]) {
  return (n / to).round() * to;
}