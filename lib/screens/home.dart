import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/task.dart';
import 'package:flutter_todo/widgets/TaskCard.dart';

import 'NoGlowBehavior.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                    child: ScrollConfiguration(
                      behavior: NoGlowBehavior(),
                      child: ListView(
                        children: [
                          TaskCardWidget(title: 'Get Stated', desc: 'Hello'),
                          TaskCardWidget(title: 'Get Stated', desc: 'Hello'),
                          TaskCardWidget(title: 'Get Stated', desc: 'Hello'),
                          TaskCardWidget(title: 'Get Stated', desc: 'Hello'),
                          TaskCardWidget(title: 'Get Stated', desc: 'Hello'),
                        ]
                      ),
                    )
                  )
                ]
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Task()));
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
