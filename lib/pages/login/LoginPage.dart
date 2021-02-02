import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datainn/pages/regist/RegistPage.dart';
import 'package:flutter_datainn/utils/Constant.dart';
import 'package:flutter_datainn/utils/EventBusUtil.dart';
import 'package:flutter_datainn/utils/HttpClient.dart';
import 'package:flutter_datainn/utils/LocalStorage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_apple/sign_in_apple.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>{

  var _userNameController = new TextEditingController();
  var _userPassController = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    SignInApple.handleAppleSignInCallBack(onCompleteWithSignIn: (String name,
        String mail,
        String userIdentifier,
        String authorizationCode,
        String identifyToken) async {
      print("flutter receiveCode: \n");
      print(authorizationCode);
      print("flutter receiveToken \n");
      print(identifyToken);
      var param = {
        "mail":mail,
        "userIdentifier":userIdentifier,
        "authorizationCode":authorizationCode,
        "identifyToken":identifyToken
      };

      HttpController.post(Constant.baseUrl+"/app/appleLogin", (data){
        var userInfo = jsonDecode(data);
        LocalStorage.setStringItem("userName", "Apple User");
        LocalStorage.setStringItem("userId", userInfo["data"]);
        LocalStorage.setBoolItem("isLogin", true);
        EventBusUtil.fire(LoginEvent(LoginEvent.eventIn));
        Navigator.of(context).pop();
      },params: param);
    }, onCompleteWithError: (AppleSignInErrorCode code) async {
      var errorMsg = "unknown";
      switch (code) {
        case AppleSignInErrorCode.canceled:
          errorMsg = "user canceled request";
          break;
        case AppleSignInErrorCode.failed:
          errorMsg = "request fail";
          break;
        case AppleSignInErrorCode.invalidResponse:
          errorMsg = "request invalid response";
          break;
        case AppleSignInErrorCode.notHandled:
          errorMsg = "request not handled";
          break;
        case AppleSignInErrorCode.unknown:
          errorMsg = "request fail unknown";
          break;
      }
      print(errorMsg);
    });
    super.initState();
  }

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
              padding: EdgeInsets.fromLTRB(60, 10, 60, 0),
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
              padding: EdgeInsets.fromLTRB(60, 5, 60, 0),
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
                padding: EdgeInsets.fromLTRB(60, 20, 60, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: RaisedButton(
                    color: Colors.blue[300],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      "登陆",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () {
                      login();
                    },
                  ),
                )
            ),
            Expanded(
                child: Container()
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width:MediaQuery.of(context).size.width/4 ,height: 1,child: null, color: Colors.grey,),
                Text("第三方登陆"),
                Container(width:MediaQuery.of(context).size.width/4 ,height: 1,child: null, color: Colors.grey,),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            AppleSignInSystemButton(
              width: 250,
              height: 50,
              buttonStyle: AppleSignInSystemButtonStyle.black,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     IconButton(
            //         iconSize: 10,
            //         icon: Image.asset("images/logo_qq.png"),
            //         onPressed: () {
            //           Fluttertoast.showToast(msg: "暂未开放第三方登陆，敬请期待");
            //         }
            //     ),
            //     SizedBox(width: 30,),
            //     IconButton(
            //         iconSize: 10,
            //         icon: Image.asset("images/logo-wechat.png"),
            //         onPressed: () {
            //           Fluttertoast.showToast(msg: "暂未开放第三方登陆，敬请期待");
            //         }
            //     )
            //   ],
            // ),
            // SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                    onPressed: null,
                    child: Text("忘记密码?")
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder:(_) {
                            return RegistPage();
                          })
                      );
                    },
                    child: Text("快速注册")
                ),
              ],
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  void login() async{
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
    HttpController.post(Constant.baseUrl+"/app/mobileLogin", (data) {
      print(data);
      final jsonData = jsonDecode(data);
      if (jsonData["msg"] == "success") {
        LocalStorage.setStringItem("userName", userName);
        LocalStorage.setStringItem("userId", jsonData["data"]);
        LocalStorage.setBoolItem("isLogin", true);
        EventBusUtil.fire(LoginEvent(LoginEvent.eventIn));
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(msg: jsonData["data"], toastLength: Toast.LENGTH_LONG);
      }
    }, params: param, errorCallback: (err) {
      print(err);
    });
  }

}