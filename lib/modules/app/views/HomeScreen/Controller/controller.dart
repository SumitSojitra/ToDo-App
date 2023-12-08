import 'package:get/get.dart';

import '../../../Helper/SqliteHelper/SqliteHelper.dart';
import '../model/model.dart';

class HomeController extends GetxController {
  Rx? taskCtrl;
  RxString? newDate;
  RxString? newTime;

  void addData({required TaskModel model}) {
    SqliteHelper.sqliteHelper.addTasks(
        model: TaskModel.fromMap(data: {
      "task": model.task,
      "date": model.date,
      "time": model.time,
    }));
  }
}
