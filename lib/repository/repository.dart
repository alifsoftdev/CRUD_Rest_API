

import '../models/todo.dart';

abstract class Repository {
  //get
  Future<List<Todo>> getTodoList();
  //fatch
  Future<String> fatchCompleted(Todo todo);
  //put
  Future<String> putCompleted(Todo todo);
  //delete
  Future<String> deletedTodo(Todo todo);
  //post
  Future<String> postTodo(Todo todo);
}

