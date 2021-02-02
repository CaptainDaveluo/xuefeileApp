import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datainn/pages/login/LoginPage.dart';
import 'package:flutter_datainn/utils/EventBusUtil.dart';
import 'package:flutter_datainn/utils/LocalStorage.dart';
import 'package:flutter_datainn/widgets/MineCardList.dart';
import 'package:flutter_datainn/widgets/MineHeader.dart';

class MinePage extends StatefulWidget {

    MinePage({Key key}) : super(key : key);

    @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
            "我的",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Image.asset("images/user_exit.png", width: 20,),
            onPressed: () {
              LocalStorage.setBoolItem("isLogin", false);
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                LocalStorage.setBoolItem("isLogin", false);
                LocalStorage.setStringItem("userId", "");
                EventBusUtil.fire(new LoginEvent(LoginEvent.eventOut));
                return LoginPage();
              }));
            }
          )
        ],
      ),
      body: Container(
        color: Color.fromRGBO(244, 244, 244, 1),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 20,
            ),
            MineHeader(),
            SizedBox(height: 10,),
            MineCardList(),
          ],
        ),
      )
    );
  }
}