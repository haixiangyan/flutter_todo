import 'package:flutter/material.dart';
import 'package:flutter_todo/models/task.dart';
import 'package:flutter_todo/utils/db_helper.dart';
import 'package:flutter_todo/widgets/Todo.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
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
                                DBHelper _dbHelper = DBHelper();
                                Task _newTask = Task(title: value);
                                await _dbHelper.insertTask(_newTask);

                                print('New task has been created');
                              }
                            },
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
                  Todo(text: 'Create your first task', isDone: true),
                  Todo(text: 'Create your first todo as well', isDone: false),
                  Todo(isDone: true),
                  Todo(isDone: false),
                ]
              ),
              Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage()));
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

