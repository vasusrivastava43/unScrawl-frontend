import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/widgets.dart';

class ResultScreenTwo extends StatelessWidget {
  const ResultScreenTwo({
    Key? key,
    required this.alphabetsUrl,
    required this.spellingUrl,
    required this.alphabetsList,
  }) : super(key: key);

  final List<String> alphabetsUrl;
  final List<String> spellingUrl;
  final List<String> alphabetsList;

  List<Widget> getText(int index) {
    List<Widget> list1 = [];
    for (int i = 0; i < alphabetsList[index].length; i++) {
      if (i == alphabetsList[index].length - 1) {
        list1.add(Text(
          '${alphabetsList[index][i]}  ',
          style: TextStyle(fontFamily: 'jimmy', fontSize: 40),
        ));
      } else {
        list1.add(Text(
          '${alphabetsList[index][i]}, ',
          style: TextStyle(fontFamily: 'jimmy', fontSize: 40),
        ));
      }
    }
    return list1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: Text(
                    'Errors',
                    style: headingStyle,
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                    height: mainContainerHeight,
                    width: mainContainerWidth,
                    decoration: mainDecoration,
                    child: Column(
                      children: [
                        Text(
                          'Alphabets',
                          style: title,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: physicalHeight * .24,
                          width: mainContainerWidth - 10,
                          child: ListView.builder(
                            itemCount: alphabetsUrl.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Image.network(
                                      alphabetsUrl[index],
                                      scale: 2,
                                    ),
                                    Image.asset(
                                      'asset/arrow.png',
                                      height: 40,
                                      width: 60,
                                    ),
                                    Center(
                                      child: Row(children: getText(index)),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
