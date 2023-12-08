class TaskModel {
  String task;
  String date;
  String time;

  TaskModel({required this.date, required this.task, required this.time});

  factory TaskModel.fromMap({required Map data}) {
    return TaskModel(
        date: data['date'], task: data['task'], time: data['time']);
  }
}
