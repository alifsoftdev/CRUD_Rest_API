import 'package:crud_api/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/todo.dart';

class TodoRepository implements Repository {

  String dataUrl = 'https://jsonplaceholder.typicode.com';

  @override
  Future<String> deletedTodo(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    var result = "false";
    await http.delete(url).then((value){
      print(value.body);
      return result="true";
    });
    return result;
  }

  //fatch example
  //patch -> Modify passed variables only
  @override
  Future<String> fatchCompleted(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    //call back data
    String resData = "";
    //bool? -> String
    await http.patch(url, body: {
      "completed": (!todo.completed!).toString(),
    }, headers: {
      "Authorization": "your_token"
    }).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return resData = result['completed'];
    });
    return resData;
  }

  //get Example
  @override
  Future<List<Todo>> getTodoList() async {
    List<Todo> _todoList = [];
    //https://jsonplaceholder.typicode.com/todos
    var url = Uri.parse('$dataUrl/todos');
    var response = await http.get(url);
    print("status code: ${response.statusCode}");
    var body = json.decode(response.body); //convert
    //parse
    for (var i = 0; i < body.length; i++) {
      _todoList.add(Todo.fromJson(body[i]));
    }
    return _todoList;
  }

  //put Example
  @override
  Future<String> putCompleted(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    //call back data
    String resData = "";
    //bool? -> String
    await http.put(url, body: {
      "completed": (!todo.completed!).toString(),
    }, headers: {
      "Authorization": "your_token"
    }).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return resData = result['completed'];
    });
    return resData;
  }

  @override
  Future<String> postTodo(Todo todo)async {
   print("${todo.toJson()}");
  var url = Uri.parse('$dataUrl/todos/');
   var result='';
   var response=await http.post(url,body:todo.toJson() );
   print(response.statusCode);
   print(response.body);
   return "true"; 
  }
}
