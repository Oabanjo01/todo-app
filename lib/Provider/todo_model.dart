class TodoModel {
  String title;
  String description;
  String? id = DateTime.now().toString();
  bool isChecked;
  bool isFavourited;

  TodoModel({
    required this.title,
    required this.description,
    this.id,
    this.isChecked = false,
    this.isFavourited = false
  });
}
