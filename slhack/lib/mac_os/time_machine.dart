import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:slhack/final_screen.dart';

class TimeMachineSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return TimeMachineWindow();
      },
      itemCount: 10,
      itemWidth: 380.0,
      itemHeight: 290.0,
      layout: SwiperLayout.STACK,
    );
  }
}

class TimeMachineWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/time_machine_docs.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: InkWell(
              onTap: () {
                Navigator.push(context, RotationRoute(page: FinalScreen()));
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image(
                        image: AssetImage(
                            'images/slhack.png'), // AssetImage('images/machd.png'),
                        width: 36,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70, right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Slhack\n.backup', //'Macintosh\nHDD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RotationRoute extends PageRouteBuilder {
  final Widget page;
  RotationRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              RotationTransition(
            turns: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.linear,
              ),
            ),
            child: child,
          ),
        );
}
