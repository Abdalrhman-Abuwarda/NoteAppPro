class Task{
  // Task({required this.title, required this.id, required this.student_id, required this.created_at, required this.updated_at, required this.is_done});
  late String title;
  late String studentId;
  late String updatedAt;
  late String createdAt;
  late int id;
  late bool isDone;

  Task.fromJson(Map<String, dynamic> json){
    title = json["title"];
    studentId = json["student_id"].toString();
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
    isDone = json["is_done"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data =  <String, dynamic>{};
    data["title"] = title;
    data["student_id"] = studentId;
    data["updated_at"] = updatedAt;
    data["created_at"] = createdAt;
    data["id"] = id;
    data["is_done"] = isDone;
    return data;
  }
  // static List<Task> tasks = [
    // Task(taskName: "task 1"),
    // Task(taskName: "task 2"),
    // Task(taskName: "task 3"),
    // Task(taskName: "task 4"),
    // Task(taskName: "task 5"),
  // ];
}