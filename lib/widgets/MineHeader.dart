import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_datainn/utils/EventBusUtil.dart';
import 'package:flutter_datainn/utils/LocalStorage.dart';

class MineHeader extends StatefulWidget{
  MineHeader({Key key}):super(key : key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MineHeaderState();
  }
}

class _MineHeaderState extends State<MineHeader> {

  bool isLogin;

  StreamSubscription<LoginEvent> _loginSubscription;

  @override
  void initState() {
    // TODO: implement initState
    _loginSubscription = EventBusUtil.listen((event) {
      _checkLogin();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _checkLogin();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (isLogin == null)
      isLogin = false;
    return isLogin?_loginedHeader(context):_unloginedHeader(context);
  }

  _checkLogin() async{
    bool loginValue = await LocalStorage.getBoolItem("isLogin");
    setState(() {
      isLogin = loginValue;
    });
  }
}

Widget _loginedHeader(context) {
  return Stack(
    children: [
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width -40,
          child: Card(
            color: Colors.white,
            child: Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "累计学习",
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1)
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "0",
                            style: TextStyle(
                                fontSize: 27
                            ),
                          ),
                          Text("节")
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "今日学习",
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1)
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "0",
                            style: TextStyle(
                                fontSize: 27
                            ),
                          ),
                          Text("节")
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
          ),
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        ),
      ),
      Align(
          child: Container(
            width: 70,
            height: 70,
            child: ClipOval(
              child: Container(
                color: Colors.white,
              ),
            ),
          )
      ),
      Align(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Image.asset("images/head_icon.png",width: 60,height: 60,),
          )
      )
    ],
  );
}

Widget _unloginedHeader(context) {
  return Stack(
    children: [
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width -40,
          child: Card(
            color: Colors.white,
            child: Container(
              height: 100,
              child: FlatButton(
                child: Text("您还未登陆，点击此处登陆"),
                onPressed: (){
                  Navigator.pushNamed(context,'/login');
                },
              )
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
          ),
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        ),
      ),
    ],
  );
}