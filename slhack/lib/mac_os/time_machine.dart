import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TimeMachineSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return TimeMachinaWindow();
      },
      itemCount: 10,
      itemWidth: 380.0,
      itemHeight: 290.0,
      layout: SwiperLayout.STACK,
    );
  }
}

class TimeMachinaWindow extends StatelessWidget {
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
        )
        //
      ],
    );
  }
}
