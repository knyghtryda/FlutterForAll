import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MacDock extends StatefulWidget {
  @override
  _MacDockState createState() => _MacDockState();
}

class _MacDockState extends State<MacDock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(3),
          topRight: Radius.circular(3),
        ),
        color: Colors.grey[300].withOpacity(0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: _centerMenus()),
        ],
      ),
    );
  }

  List<Widget> _centerMenus() => <Widget>[
        Image(image: AssetImage('images/app-store-2019-09-25.png'), width: 42),
        SizedBox(width: 10),
        Image(
            image: AssetImage('images/macos-catalina-2019-10-08.png'),
            width: 42),
        SizedBox(width: 10),
        Image(image: AssetImage('images/music-2019-09-25.png'), width: 42),
        SizedBox(width: 10),
        Image(image: AssetImage('images/safari-2019-09-25.png'), width: 42),
        SizedBox(width: 10),
        Image(image: AssetImage('images/preview-2019-09-25.png'), width: 42),
      ];
}
