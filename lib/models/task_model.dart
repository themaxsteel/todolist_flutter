class TaskModel {
  String? name;
  String? level;
  String? category;
  String? date;
  String? id;

  TaskModel({this.name, this.level, this.category, this.date, this.id});

  TaskModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    level = json['level'];
    category = json['category'];
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['level'] = level;
    data['category'] = category;
    data['date'] = date;
    data['id'] = id;
    return data;
  }
}
