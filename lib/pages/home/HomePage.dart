import 'package:flutter/material.dart';
import 'package:flutter_datainn/pages/home/HomeCoursesPage.dart';
import 'package:flutter_datainn/pages/home/VIPPage.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 45),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 45,
                          width: 160,
                          child: TabBar(
                            labelColor: Colors.black,
                            labelStyle: TextStyle(fontSize: 20),
                            indicatorPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Color.fromRGBO(102, 133, 252, 1),
                            indicatorWeight: 3,
                            tabs: [
                              Tab(
                                text: "课程",
                              ),
                              // Tab(text: "VIP"),
                            ],
                            controller: _tabController,
                          ),
                        )
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
        controller: _tabController,
        children: [
          HomeCoursesPage(),
          // VIPPage()
      ],
    ));
  }

}
