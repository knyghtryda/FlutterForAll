import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WinDesk extends StatefulWidget {
  @override
  _WinDeskState createState() => _WinDeskState();
}

class _WinDeskState extends State<WinDesk> {
  bool isShowList = false;

  @override
  void initState() {
    // TODO: implement initState
    isShowList =false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final buttonView =  Align(
      alignment: Alignment.bottomLeft,
      child: RaisedButton(
        onPressed: () {
          setState(() {
            isShowList = true;
          });
        },
        child: const Text('', style: TextStyle(fontSize: 20)),
        color: Colors.transparent,
        textColor: Colors.white,
        elevation: 5,
      ),
    );


    final startupView =  Align(
      alignment: Alignment.bottomLeft,
      child: RaisedButton(
        onPressed: () {
          setState(() {
            isShowList = false;
          });
        },
        child: Image.asset(
                    "assets/listview.png",
                    fit: BoxFit.contain,
                  ),
        color: Colors.transparent,
        elevation: 5,
      ),
    );

    return Container(
      height: 50,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Windows_95_Desktop_screenshot.png"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(''),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                onPressed: () {
                    Navigator.pop(context);
                }),
          ),
          body: Center(child: !isShowList?buttonView:startupView),

        ),
      );
  }


}

/// This is the stateless widget that the main application instantiates.
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: RaisedButton(
        onPressed: () {
          
        },
        child: const Text('', style: TextStyle(fontSize: 20)),
        color: Colors.transparent,
        textColor: Colors.white,
        elevation: 5,
      ),
    );
  }
}

