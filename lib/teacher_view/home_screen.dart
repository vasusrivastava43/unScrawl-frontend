import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/managers.dart';
import '../theme.dart';
import '../widgets/widgets.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<TeacherManager>(context);

    return Stack(
      children: [
        Background(),
        SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'voll',
                          ),
                        ),
                        Text(
                          manager.teacher.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'voll',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: ProfileAvatar(
                        text: manager.teacher.name[0],
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: physicalHeight * .25,
                width: mainContainerWidth,
                decoration: mainDecoration,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 60.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TopFiveStudent(),
                      SizedBox(
                        height: 20,
                      ),
                      TopFiveStudent(),
                      SizedBox(
                        height: 20,
                      ),
                      TopFiveStudent(),
                      SizedBox(
                        height: 20,
                      ),
                      TopFiveStudent(),
                      SizedBox(
                        height: 20,
                      ),
                      TopFiveStudent(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class TopFiveStudent extends StatelessWidget {
  const TopFiveStudent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/star.png',
          height: 30,
          width: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 15.0),
          child: Container(
            height: physicalHeight * .03,
            width: physicalWidth * .2,
            decoration: cardDecoration,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: ProfileAvatar(
                    text: 'V',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vasu',
                        softWrap: true,
                        style: title,
                      ),
                      Text(
                        '10',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
