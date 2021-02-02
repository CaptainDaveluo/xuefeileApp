import 'package:flutter/material.dart';
import 'package:flutter_datainn/pages/courses/CourseListPage.dart';
import 'package:flutter_datainn/utils/LocalStorage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MineCardList extends StatefulWidget {
  MineCardList({Key key}) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MineCardListState();
  }
}

class _MineCardListState extends State<MineCardList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset("images/mine_myclass.png",width: 38,height: 38,),
              title: Text("我的课程"),
              subtitle: Text("社会总是善待努力学习的人"),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder:(_) {
                      return CourseListPage(keyword: "myCourse",);
                    })
                );
              },
            ),
            // Divider(),
            // ListTile(
            //   leading: Image.asset("images/mine_myworks.png",width: 38,height: 38,),
            //   title: Text("我的作业"),
            //   subtitle: Text("积少成多，检验收获"),
            //   onTap: () {
            //     Fluttertoast.showToast(msg: "功能尚未开放，敬请期待");
            //   },
            // ),
            Divider(),
            ListTile(
              onTap: () async {
                var isLogin = await LocalStorage.getBoolItem("isLogin");
                if (isLogin==null||isLogin==false) {
                  Fluttertoast.showToast(msg: "您当前未登陆，请先登录!");
                  return;
                }
                Navigator.of(context).push(
                    MaterialPageRoute(builder:(_) {
                      return CourseListPage(keyword: "star",);
                    })
                );
              },
              leading: Image.asset("images/mine_myconcern.png",width: 38,height: 38,),
              title: Text("我的关注"),
              subtitle: Text("关注的人、课程"),
            ),
            // Divider(),
            // ListTile(
            //   leading: Image.asset("images/mine_mywallet.png",width: 38,height: 38,),
            //   title: Text("我的钱包"),
            //   subtitle: Text("查看余额、优惠券"),
            //   onTap: () {
            //     Fluttertoast.showToast(msg: "功能尚未开放，敬请期待");
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}