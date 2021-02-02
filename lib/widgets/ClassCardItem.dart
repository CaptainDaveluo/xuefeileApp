import 'package:flutter/material.dart';
import 'package:flutter_datainn/pages/home/models/Course.dart';

class ClassCardItem extends StatefulWidget {
  final String imageStr;
  final String title;
  final String description;
  final Course course;

  ClassCardItem({Key key,this.title,this.imageStr,this.description,this.course}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ClassCardItemState();
  }
}

class _ClassCardItemState extends State<ClassCardItem> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/courseDetail", arguments: widget.course);
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 100,
            height: 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(widget.imageStr,width:  MediaQuery.of(context).size.width - 100, height: 160,fit: BoxFit.fitWidth,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(
                          fontSize: 10,
                          color: Color.fromRGBO(153, 153, 153, 1)
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}