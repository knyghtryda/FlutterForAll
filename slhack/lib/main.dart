import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slhack/amazon_lex/amazon_lex.dart';
import 'package:slhack/command_prompt/command_prompt.dart';
import 'package:slhack/command_prompt/game_state.dart';
import 'package:slhack/mac_os/desktop_screen.dart';
import 'package:slhack/mac_os/macos_state.dart';
import 'package:slhack/win95/win95page.dart';
import 'package:slhack/win95/win95dk.dart';
import 'package:slhack/future/future_ui_mobile.dart';
import 'package:slhack/future/future_ui_web.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter For All Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final rnd = Random();
  int _counter = 0;
  List<Widget> corruption = [];
  AmazonLex lex = AmazonLex();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      if (_counter > 4) {
        for (int i = 0; (i - 10) < rnd.nextInt(_counter * 10); i++) {
          corruption.add(Align(
            alignment:
                Alignment(rnd.nextDouble() * 2 - 1, rnd.nextDouble() * 2 - 1),
            child: Text(
              'HELP ME',
              style: TextStyle(
                  shadows: [Shadow(color: Colors.green[100], blurRadius: 8)],
                  fontFamily: 'VT323',
                  fontSize:
                      rnd.nextInt(_counter * 10).toDouble() + _counter * 10,
                  color:
                      Colors.green[(900 - (_counter - 2) * 100).clamp(0, 900)]),
            ),
          ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
                MaterialButton(
                  child: Text('Command Prompt'),
                  onPressed: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, a1, a2) => Theme(
                        data: ThemeData(
                          brightness: Brightness.dark,
                          canvasColor: Colors.black,
                          textTheme: TextTheme(
                            bodyText1: TextStyle(
                                fontFamily: 'VT323',
                                fontSize: 32,
                                color: Colors.lightGreenAccent,
                                shadows: [
                                  Shadow(
                                      color: Colors.lightGreen[200],
                                      blurRadius: 5)
                                ]),
                          ),
                        ),
                        child: ChangeNotifierProvider(
                            create: (_) {
                              var gameState = GameState();
                              gameState.init();
                              return gameState;
                            },
                            child: CommandPrompt()),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  child: Text('Lex Test'),
                  onPressed: () {
                    lex.postResponse('where am i');
                  },
                ),
                MaterialButton(
                  child: Text('Windows 95'),
                  onPressed: () => Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => WinDesk())),
                          //builder: (context) => Flutter95App())),
                          
                ),
                MaterialButton(
                    child: Text('macos desk'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (_) => MacosState(),
                            child: MacosDesktopScreen(),
                          ),
                        ),
                      );
                    }),
                MaterialButton(
                  child: Text('Future UI'),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FutureUiMobile())),
                ),
              ],
            ),
          ),
          IgnorePointer(
            child: Container(
              color: Color.fromRGBO(0, 0, 0, (_counter / 10).clamp(0, 1)),
            ),
          ),
          ...corruption,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
