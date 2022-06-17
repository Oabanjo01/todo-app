// ignore_for_file: prefer_const_declarations

String todoTable = 'TodoTable';

class TodoFields {
  static final String title = 'title';
  static final String description = 'description';
  static final String isChecked = 'isChecked';
  static final String created = 'created';
  static final String isFavourited = 'isFavourited';

}
class TodoModel {
  String title;
  String description;
  final DateTime created;
  bool isChecked;
  bool isFavourited;

  TodoModel({
    required this.title,
    required this.description,
    required this.created,
    this.isChecked = false,
    this.isFavourited = false
  });

  Map<String, Object?> toMap () {
    return {
      TodoFields.title: title,
      TodoFields.description: description,
      TodoFields.created: created.toIso8601String(),
      TodoFields.isChecked: isChecked ? 1 : 0,
      TodoFields.isFavourited: isFavourited ? 1 : 0
    };
  }

  static TodoModel fromMap(Map<String, Object?> map) {
    return TodoModel (
      title: map[TodoFields.title] as String,
      description: map[TodoFields.description] as String,
      created: DateTime.parse(map[TodoFields.created] as String),
      isChecked: map[TodoFields.isChecked] == 1 ? true : false,
      isFavourited: map[TodoFields.isFavourited] == 1 ? true : false
    );
  }
}
