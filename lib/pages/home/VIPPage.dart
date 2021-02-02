import 'package:flutter/material.dart';
import 'package:flutter_datainn/utils/LocalStorage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VIPPage extends StatefulWidget{
  VIPPage({Key key}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VIPageState();
  }
}

class VIPageState extends State<VIPPage> {
  String userName = "";

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    var loginName = await LocalStorage.getStringItem("userName");
    setState(() {
      if (loginName == null || loginName == ""){
        loginName = "您还未登陆";
      }
      userName = loginName;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Container(
                    child: Image.asset("images/vip_bg_top.png"),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
                        child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(25, 25, 20, 0),
                                child: ClipOval(
                                  child: Image.asset("images/head_icon.png", width: 65,),
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.only(top:25),
                              child: Container(
                                height: 65,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      this.userName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    Text(
                                      "您还不是会员",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Container(
                              width: MediaQuery.of(context).size.width/3,
                              height: 1.3*MediaQuery.of(context).size.width/3,
                              // color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10,20,10,20),
                                    child: Image.asset("images/vip_logo.png", height: 30,),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    children: [
                                      Text("¥",style: TextStyle(fontSize: 18),),
                                      Text("80",style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),),
                                      Text("/季度",style: TextStyle(fontSize: 18),)
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Text("¥120/季度", style: TextStyle(fontSize: 18, color:Colors.grey ,decoration: TextDecoration.lineThrough),)
                                ],
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Container(
                              width: MediaQuery.of(context).size.width/3,
                              height: 1.3*MediaQuery.of(context).size.width/3,
                              // color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(height: 70,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    children: [
                                      Text("¥",style: TextStyle(fontSize: 18),),
                                      Text("30",style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),),
                                      Text("/月",style: TextStyle(fontSize: 18),)
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Text("¥40/月", style: TextStyle(fontSize: 18, color:Colors.grey ,decoration: TextDecoration.lineThrough),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 25,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: Text("立即购买"),
                            onPressed: () {
                              Fluttertoast.showToast(msg: "对不起，暂未开放充值，敬请期待",toastLength: Toast.LENGTH_LONG);
                            }
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Stack(
              children: [
                Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        child: Image.asset("images/vip_bg_bottom.png"),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 15.0), //阴影xy轴偏移量
                                  blurRadius: 15.0, //阴影模糊程度
                                  spreadRadius: 1.0
                              )
                            ]
                        ),
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.deepOrangeAccent,
                            width: 60,
                            height: 1,
                          ),
                          Image.asset("images/vip_shape.png"),
                          SizedBox(width: 10,),
                          Text("会员专属特权"),
                          SizedBox(width: 10,),
                          Image.asset("images/vip_shape.png"),
                          Container(
                            color: Colors.deepOrangeAccent,
                            width: 60,
                            height: 1,
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset("images/vip_pic1.png", width: 60,),
                              SizedBox(height: 10,),
                              Text("享受积分抵扣")
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset("images/vip_pic2.png", width: 60,),
                              SizedBox(height: 10,),
                              Text("更多免费视频")
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset("images/vip_pic3.png", width: 60,),
                              SizedBox(height: 10,),
                              Text("更多图片预览")
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 25,),
                      Text("更多特权敬请期待......", style: TextStyle(fontSize: 13, color: Colors.grey),)
                    ],
                  )
                ),
              ],
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}