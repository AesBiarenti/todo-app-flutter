class TodoModel {
  final String id;
  final String name;

  TodoModel(this.id, {required this.name});
  TodoModel copyWith({String? name}) {
    return TodoModel(id, name: name ?? this.name);
  }
}
