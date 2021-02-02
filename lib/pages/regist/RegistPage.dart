

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datainn/utils/Constant.dart';
import 'package:flutter_datainn/utils/HttpClient.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistPage extends StatefulWidget {
  RegistPage({Key key}) : super(key : key);

  @override
  State<StatefulWidget> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  var _userNameController = new TextEditingController();
  var _userPassController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.blue[300],
                    onPressed: () {
                      Navigator.pop(context);
                    }
                ),
                SizedBox()
              ],
            ),
            SizedBox(height: 40,),
            Image.asset("images/lic.png", width: 140,),
            Padding(
              padding: EdgeInsets.fromLTRB(80, 10, 80, 0),
              child: TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.black26),
                controller: _userNameController,
                decoration: InputDecoration(
                  hintText: "用户名",
                  prefixIcon: Padding(padding: EdgeInsets.only(right: 10),child: Image.asset("images/login_user.png", width: 10,),),
                  prefixIconConstraints: BoxConstraints.tight(Size(30,30)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(80, 5, 80, 0),
              child: TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.black26),
                controller: _userPassController,
                decoration: InputDecoration(
                  hintText: "密码",
                  prefixIcon: Padding(padding: EdgeInsets.only(right: 10),child: Image.asset("images/login_pass.png", width: 10,),),
                  prefixIconConstraints: BoxConstraints.tight(Size(30,30)),
                ),
                obscureText: true,
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(80, 50, 80, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: RaisedButton(
                    color: Colors.blue[300],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      "注册",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () {
                      regist();
                      //login();
                    },
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  void regist() async {
    var userName = _userNameController.text;
    var userPass = _userPassController.text;
    if (userName.length != 11) {
      Fluttertoast.showToast(msg: "请输入手机号码");
      return;
    }
    if (userPass.length == 0) {
      Fluttertoast.showToast(msg: "密码不能为空");
      return;
    }
    var param = {
      "userName": userName,
      "userPass": userPass,
    };
    HttpController.post(Constant.baseUrl+"/app/mobileRegist", (data){
      print(data);
      Map<String, dynamic> jsonData = jsonDecode(data);
      if (jsonData["msg"] == "success") {
        Fluttertoast.showToast(msg: "注册成功,快去登陆吧", toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(msg: jsonData["data"], toastLength: Toast.LENGTH_LONG);
      }
    }, params: param);
  }
}