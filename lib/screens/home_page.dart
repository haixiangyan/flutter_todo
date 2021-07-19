import 'package:flutter/material.dart';
import 'package:flutter_todo/models/task.dart';
import 'package:flutter_todo/screens/task_page.dart';
import 'package:flutter_todo/utils/db_helper.dart';
import 'package:flutter_todo/widgets/TaskCard.dart';

import '../widgets/NoGlowBehavior.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBHelper _dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          color: Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(image: AssetImage('assets/images/logo.png')),
                  Container(
                    margin: EdgeInsets.only(
                      top: 32.0,
                      bottom: 32.0,
                    )
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: _dbHelper.getTasks(),
                      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehavior(),
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TaskPage(
                                      task: snapshot.data![index]
                                    ))
                                  );
                                },
                                child: TaskCardWidget(
                                  title: snapshot.data![index].title,
                                  desc: snapshot.data![index].desc,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
                  )
                ]
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => TaskPage(task: null))
                    ).then((value) {
                      setState(() {}); // 更新状态
                    });
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF7349FE), Color(0xFF643FDB)],
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, 1.0),
                      ),
                      borderRadius: BorderRadius.circular(50.0)
                    ),
                    child: Image(image: AssetImage('assets/images/add_icon.png'))
                  ),
                )
              )
            ],
          )
        )
      )
    );
  }
}
