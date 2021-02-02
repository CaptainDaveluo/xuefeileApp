import 'package:flutter/material.dart';
import 'mine/MinePage.dart';
import 'home/HomePage.dart';
import 'courses/ExplorePage.dart';
import 'messages/MessagePage.dart';

class Tabs extends StatefulWidget {
  Tabs ({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabsState();
  }
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  List _pages = [HomePage(),ExplorePage(),MessagePage(),MinePage()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Scaffold(
        body: this._pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
              setState(() {
                this._currentIndex = index;
              });
          },
          selectedItemColor: Color.fromRGBO(102, 133, 252, 1),
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Image.asset("images/tab_home.png"),
                ),
                activeIcon: Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Image.asset("images/tab_home_actived.png"),
                ),
                title: Text(
                    "首页",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
            ),
            BottomNavigationBarItem(
                icon: Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Image.asset("images/tab_class.png"),
                ),
                activeIcon: Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Image.asset("images/tab_class_actived.png"),
                ),
                title: Text(
                    "分类",
                  style: TextStyle(
                      fontSize: 10
                  ),
                )
            ),
            BottomNavigationBarItem(
                icon: Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Image.asset("images/tab_message.png"),
                ),
                activeIcon: Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Image.asset("images/tab_message_actived.png"),
                ),
                title: Text(
                    "消息",
                  style: TextStyle(
                      fontSize: 10
                  ),
                )
            ),
            BottomNavigationBarItem(
                icon: Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Image.asset("images/tab_mine.png"),
                ),
                activeIcon: Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Image.asset("images/tab_mine_actived.png"),
                ),
                title: Text(
                    "我的",
                  style: TextStyle(
                      fontSize: 10
                  ),
                )
            )
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}