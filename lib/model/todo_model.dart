
import 'package:hive/hive.dart';

part 'todo_model.g.dart';


@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  TodoModel({required this.id, required this.name});
  TodoModel copyWith({String? id, String? name}) {
    return TodoModel(id: id ?? this.id, name: name ?? this.name);
  }
}
