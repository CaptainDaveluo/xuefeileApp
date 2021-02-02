import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget{
    MessagePage({Key key}) : super(key:key);

    @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MessagePageState();
  }
}

class _MessagePageState extends State<MessagePage> {
    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "消息",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          FlatButton(
            child: Text("都标为已读"),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 100,),
            Container(
              alignment: Alignment.center,
              child: Image.asset("images/none.png"),
            ),
            Container(
              child: Text(
                  "暂无通知",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey
                ),
              ),
            )
            // ListTile(
            //   title: Text("今日热点"),
            //   subtitle: Text("有分量的排行榜！！"),
            //   leading: Image.asset("images/message_hot.png", height: 50, width: 50,),
            //   trailing: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children:[
            //       Text(
            //           "10-28",
            //           style: TextStyle(
            //             fontSize: 12,
            //             color: Color.fromRGBO(187, 187, 187, 1)
            //           ),
            //       ),
            //       ClipOval(
            //         child: Container(
            //           child: Text(
            //               "4",
            //               style: TextStyle(
            //                 fontSize: 12,
            //                 color: Colors.white
            //               ),
            //           ),
            //           color: Color.fromRGBO(102, 133, 252, 1),
            //           alignment: Alignment.center,
            //           width: 20,
            //           height: 20,
            //         ),
            //       )
            //     ]
            //   ),
            // ),
            // Divider(),
            // ListTile(
            //   title: Text("大神C4D案例实战讲解"),
            //   subtitle: Text("设计研究室:欢迎新朋友【温馨提示】"),
            //   leading: Image.asset("images/message_task.png", height: 50, width: 50,),
            //   trailing: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children:[
            //         Text(
            //           "03-26",
            //           style: TextStyle(
            //               fontSize: 12,
            //               color: Color.fromRGBO(187, 187, 187, 1)
            //           ),
            //         ),
            //         SizedBox(
            //           height: 15,
            //         )
            //       ]
            //   ),
            // ),
            // Divider(),
            // ListTile(
            //   title: Text("我的通知"),
            //   subtitle: Text("Hi~我是你的通知酱，初次见面请多关照哈..."),
            //   leading: Image.asset("images/message_mynotify.png", height: 50, width: 50,),
            //   trailing: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children:[
            //         Text(
            //           "03-10",
            //           style: TextStyle(
            //               fontSize: 12,
            //               color: Color.fromRGBO(187, 187, 187, 1)
            //           ),
            //         ),
            //         SizedBox(
            //           height: 15,
            //         )
            //       ]
            //   ),
            // ),
            // Divider(),
            // ListTile(
            //   title: Text("攻略"),
            //   subtitle: Text("新人攻略，带你玩转课程"),
            //   leading: Image.asset("images/message_introduction.png", height: 50, width: 50,),
            //   trailing: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children:[
            //         Text(
            //           "03-10",
            //           style: TextStyle(
            //               fontSize: 12,
            //               color: Color.fromRGBO(187, 187, 187, 1)
            //           ),
            //         ),
            //         ClipOval(
            //           child: Container(
            //             child: Text(
            //               "1",
            //               style: TextStyle(
            //                   fontSize: 12,
            //                   color: Colors.white
            //               ),
            //             ),
            //             color: Color.fromRGBO(102, 133, 252, 1),
            //             alignment: Alignment.center,
            //             width: 20,
            //             height: 20,
            //           ),
            //         )
            //       ]
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}