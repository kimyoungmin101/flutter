import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/models/todo_list.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class Todo {
  bool isDone;
  String title;

  Todo(this.title, {this.isDone = false});
}


class _TodoListPageState extends State<TodoListPage> {
  var _todoController = TextEditingController();

  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('남은 할 일'),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        controller: _todoController,
                        decoration: InputDecoration(
                            hintText: '할일 입력',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent))),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Container(
                        color: Colors.black12,
                        child: MaterialButton(
                          onPressed: () {
                            _addTodo(Todo(_todoController.text));
                          },
                          child: Text('추가'),
                        ),
                      ),
                    ))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
  void _addTodo(Todo todo) {
    final f = FirebaseFirestore.instance;
    f.collection('TODOLIST').add({'title': todo.title, 'idDone' : todo.isDone});

    _todoController.text = '';
  }
}


