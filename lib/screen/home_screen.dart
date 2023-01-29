
import 'package:flutter/material.dart';

import '../controller/controller.dart';
import '../models/todo.dart';
import '../repository/todo_repository.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //dependency injection
    var todoController = TodoController(TodoRepository());
    //test
    todoController.fatchTodoList();
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD REST API"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Todo>>(
          future: todoController.fatchTodoList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('error'),
              );
            }
            return buildBodyContent(snapshot, todoController);
          }),
          floatingActionButton: FloatingActionButton(onPressed: (){
            Todo todo= Todo(userId: 3,title: "simple Post",completed: false); 
            todoController.postTodo(todo);
          },child:Text('post') ,),
    );  
  }

  SafeArea buildBodyContent(AsyncSnapshot<List<Todo>> snapshot, TodoController todoController) {
    return SafeArea(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  var todo = snapshot.data?[index];
                  return Container(
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: Text('${todo?.id}')),
                          Expanded(flex: 3, child: Text('${todo?.title}')),
                          Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // Patch 
                                  InkWell(
                                    onTap: () {
                                      todoController
                                          .updatePatchCompleted(todo!)
                                          .then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration: Duration(milliseconds: 500),
                                            content: Text('$value'),
                                          ),
                                        );
                                      });
                                    },
                                    child: buildCallContainer(
                                        'patch', Color(0xffffe0b2)),
                                  ),
                                  //Put
                                  InkWell(
                                    onTap: () {
                                      todoController.updatePutCompleted(todo!);
                                    },
                                    child: buildCallContainer(
                                        'put', Color(0xFF81C784)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      todoController.deletedTodo(todo!).then((value){
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration: Duration(milliseconds: 500),
                                            content: Text('$value'),
                                          ),
                                        );
                                      });
                                    },
                                    child: buildCallContainer(
                                        'delete', Color(0xFFE57373)),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 0.5,
                    height: 0.5,
                  );
                },
                itemCount: snapshot.data?.length ?? 0),
          );
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
      height: 40,
      width: 40,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: Center(child: Text("$title")),
    );
  }
}
