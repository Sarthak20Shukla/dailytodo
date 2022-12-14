import 'package:dailytodo/database_helper.dart';
import 'package:dailytodo/screens/taskpage.dart';
import 'package:dailytodo/widgets.dart';
import 'package:flutter/material.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          color: Color(0xFF007B83),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(
                      top: 30.0,
                      bottom: 30.0,
                    ),
                    child: Image(
                        image: AssetImage('assets/images/logo.png')
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Taskpage(
                                        task: snapshot.data![index],
                                      ),
                                    ),
                                  ).then(
                                        (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                child: TaskCardWidget(
                                  title: snapshot.data![index].title,
                                  desc: snapshot.data![index].description,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  Taskpage()));
                  },
                  child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF15133F), Color(0xFF15133C)],
                            begin: Alignment(0.0, 1.0),
                            end: Alignment(0.0, 1.0)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image(
                            image: AssetImage("assets/images/add_icon.png")),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
