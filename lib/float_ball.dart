import 'package:flutter/material.dart';
import 'package:imusic/emiiter.dart';

// 悬浮球的 Widget
class FloatingBall extends StatelessWidget {
  final Offset offset;
  // final Function(Offset) onPanUpdate;

  // eventBus.on<MusicEvent>().listen((event) {
  // // All events are of type UserLoggedInEvent (or subtypes of it).
  // // print(event);
  // });

  // const FloatingBall({super.key, required this.offset,  this.onPanUpdate});
  const FloatingBall({super.key, required this.offset});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      // left: offset.dx,
      // top: offset.dy,
      left: MediaQuery.of(context).size.width / 2 - 30,
      bottom: 10.0,   // 距离顶部 10
      child: GestureDetector(
        // onPanUpdate: (details) {
        //   onPanUpdate(details.localPosition);
        // },
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue.withOpacity(0.5),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
