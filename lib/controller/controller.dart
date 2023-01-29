import '../models/todo.dart';
import '../repository/repository.dart';

class TodoController {
  final Repository _repository;

  TodoController(this._repository);

  //get
  Future <List< Todo>> fatchTodoList()async{
    return _repository.getTodoList();
  }
  //patch
  Future<String> updatePatchCompleted(Todo todo)async{
    return _repository.fatchCompleted(todo);
  }
    //put
  Future<String> updatePutCompleted(Todo todo)async{
    return _repository.putCompleted(todo);
}
//delete
 Future<String> deletedTodo(Todo todo)async{
    return _repository.deletedTodo(todo);
}

//post 
Future <String> postTodo(Todo todo)async{
  return _repository.postTodo(todo);
}
}