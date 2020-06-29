import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';

// class Flutter95App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       color: Flutter95.background,
//       home: MainScreen(),
//     );
//   }
// }


class Flutter95App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold95(
      title: 'Welcome Win95',
      toolbar: Toolbar95(actions: [
        Item95(
          label: 'File',
          menu: _buildMenu(),
        ),
        Item95(
          label: 'Edit',
          onTap: (context) {Navigator.pop(context);},
        ),
        Item95(
          label: 'Save',
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),

        child: Elevation95(
          type: Elevation95Type.down,
          child: Column(
            children: <Widget>[
                SizedBox(
                  height: 45.0,
                  child: Image.asset(
                    "assets/win95logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Button95(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ScreenThatCanPop()));
                    },
                    child: Text('Blue 95'),
                  ),
                  Button95(
                    child: Text('Disabled'),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Welcome to Windows 95',
                style: Flutter95.textStyle,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField95(),
              ),
              _buildListView(),
            ],
          ),
        ),
      ),
    );
  }

  Menu95 _buildMenu() {
    return Menu95(
      items: [
        MenuItem95(
          value: 1,
          label: 'New',
        ),
        MenuItem95(
          value: 2,
          label: 'Open',
        ),
        MenuItem95(
          value: 3,
          label: 'Exit',
        ),
      ],
      onItemSelected: (item) {
        if(item.value==3){
        }

      },
    );
  }

  /// Build a ListView wrapping it in [Elevation95] with [Elevation95Type.down].
  /// This will create a "deep" container.
  /// Then wrap each item with [Elevation95Type.up] to create an up effect.
  Padding _buildListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: Elevation95(
        type: Elevation95Type.down,
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 100,
            itemBuilder: (context, index) {
              return Elevation95(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Item $index',
                    style: Flutter95.textStyle,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ScreenThatCanPop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold95(
      title: 'Windows 95: The Original Blue Screen of Death',
      body: Container(
        child:   Image.asset('assets/win95blue.png'),

      ),
    );
  }
}