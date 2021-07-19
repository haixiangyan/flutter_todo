import 'package:flutter/material.dart';
import 'package:flutter_todo/models/task.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/utils/db_helper.dart';
import 'package:flutter_todo/widgets/TodoWidget.dart';

class TaskPage extends StatefulWidget {
  final Task? task;

  TaskPage({this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DBHelper _dbHelper = DBHelper();

  int _taskId = 0;
  String _taskTitle = '';

  @override
  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task!.title!;
      _taskId = widget.task!.id!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 24.0,
                      bottom: 6.0,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Image(
                              image: AssetImage('assets/images/back_arrow_icon.png')
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) async {
                              if (value != '') {
                                if (widget.task == null) {
                                  Task _newTask = Task(title: value);
                                  await _dbHelper.insertTask(_newTask);
                                } else {
                                }
                              }
                            },
                            controller: TextEditingController()..text = _taskTitle,
                            decoration: InputDecoration(
                              hintText: 'Enter task title...',
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF211551),
                            )
                          )
                        )
                      ]
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 12.0
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter description for the task...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0
                        )
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: _dbHelper.getTodos(_taskId),
                    builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Switch status
                              },
                              child: TodoWidget(
                                text: snapshot.data![index].title,
                                isDone: snapshot.data![index].isDone != 0,
                              ),
                            );
                          }
                        ),
                      );
                    }
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20.0,
                          height: 20.0,
                          margin: EdgeInsets.only(
                              right: 12.0
                          ),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: Color(0xFF86829D),
                                width: 1.5,
                              )
                          ),
                          child: Image(
                              image: AssetImage('assets/images/check_icon.png')
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) async {
                              if (value != '') {
                                if (widget.task != null) {
                                  Todo _newTodo = Todo(
                                      taskId: widget.task!.id,
                                      title: value,
                                      isDone: 0
                                  );
                                  await _dbHelper.insertTodo(_newTodo);
                                  setState(() {});
                                }
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter todo item...',
                              border: InputBorder.none,
                            ),
                          )
                        )
                      ],
                    ),
                  )
                ]
              ),
              Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () {
                    print('delete');
                  },
                  child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: Color(0xFFFE3577),
                          borderRadius: BorderRadius.circular(50.0)
                      ),
                      child: Image(image: AssetImage('assets/images/delete_icon.png'))
                  ),
                )
              )
            ],
          )
        ),
      )
    );
  }
}

