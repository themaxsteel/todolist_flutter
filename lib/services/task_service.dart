import 'package:dio/dio.dart';
import 'package:todo_list_flutter/models/task_model.dart';

class TaskService {
  String baseUrl = "https://628d95f0368687f3e705a926.mockapi.io/api";
  Dio dio = Dio();
  List<TaskModel> task = [];

  Future<List<TaskModel>> getTask() async {
    try {
      var response = await dio.get('$baseUrl/task');

      if (response.statusCode == 200) {
        List data = response.data;

        for (var item in data) {
          task.add(TaskModel.fromJson(item));
        }
        print('success');
        return task;
      } else {
        throw Exception('Something Went Wrong');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future postTask(
      String name, String category, String level, String date) async {
    try {
      var response = await dio.post(
        '$baseUrl/task',
        data: {
          'name': name,
          'category': category,
          'level': level,
          'date': date,
        },
      );
      if (response.statusCode == 201) {
        print(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future updateTask(
      int id, String name, String category, String level, String date) async {
    try {
      var response = await dio.put(
        '$baseUrl/task/$id',
        data: {
          'name': name,
          'category': category,
          'level': level,
          'date': date,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future deleteTask(int id) async {
    try {
      var response = await dio.delete('$baseUrl/task/$id');
      if (response.statusCode == 200) {
        print(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
