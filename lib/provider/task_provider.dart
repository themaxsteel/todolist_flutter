import 'package:flutter/cupertino.dart';
import 'package:todo_list_flutter/models/task_model.dart';
import 'package:todo_list_flutter/services/task_service.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _task = [];
  List<TaskModel> get task => _task;
  set task(List<TaskModel> task) {
    _task = task;
    notifyListeners();
  }

  //Login Username
  String name = '';
  setName(String value) {
    name = value;
    notifyListeners();
  }

  //Loading Statement
  bool isLoading = false;
  setLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> getTask() async {
    try {
      List<TaskModel> task = await TaskService().getTask();
      _task = task;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  //Post Task
  int category = 0;
  int level = 0;
  String date = "Sunday";

  setCategory(int number) {
    category = number;
    notifyListeners();
  }

  setLevel(int number) {
    level = number;
    notifyListeners();
  }

  setDate(String value) {
    date = value;
    notifyListeners();
  }

  Future postTask(String name) async {
    try {
      setLoading();
      String setCategory = category == 0 ? 'Works' : 'Routines';
      String setLevel = level == 0
          ? 'Easy'
          : level == 1
              ? 'Medium'
              : 'Hard';

      await TaskService().postTask(name, setCategory, setLevel, date);
      await getTask();
      setLoading();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future deleteTask(int id) async {
    try {
      setLoading();
      await TaskService().deleteTask(id);
      await getTask();
      setLoading();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future updateTask(int id, String name) async {
    try {
      setLoading();
      String setCategory = category == 0 ? 'Works' : 'Routines';
      String setLevel = level == 0
          ? 'Easy'
          : level == 1
              ? 'Medium'
              : 'Hard';

      await TaskService().updateTask(id, name, setCategory, setLevel, date);
      await getTask();
      setLoading();
      return true;
    } catch (e) {
      return false;
    }
  }
}
