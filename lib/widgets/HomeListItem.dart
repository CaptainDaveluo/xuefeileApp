import 'package:flutter/material.dart';

class HomeListItem extends StatefulWidget{
  HomeListItem({Key key}) : super(key:key);

  _HomeListItemState createState()=>_HomeListItemState();
}

class _HomeListItemState extends State<HomeListItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 80,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            width: 75,
            height: 75,
            child: Image.asset("images/logo-alipay.png"),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 20),
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "这个就是标题",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10,),
                Text(
                  "这里是描述内容",
                  style: TextStyle(
                      fontSize: 12
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
          )

        ],
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))
      ),
    );
  }
}