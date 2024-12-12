import 'package:flutter/material.dart';
import 'package:imusic/emiiter.dart';

// 悬浮球的 Widget
class FloatingBall extends StatefulWidget {
  @override
  _FloatingBallState createState() => _FloatingBallState();
}
class _FloatingBallState extends State<FloatingBall>  {

  @override
  void initState() {
    super.initState();
    // 在页面初始化时开始监听事件
    print(3333);
    eventBus.on<MusicEvent>().listen((event) {
      // 获取事件中的数据
      Map<String, dynamic> eventData = event.data;
      // 打印传递的数据
      print("Event Type: ${eventData['type']}");
      print("Params: ${eventData['params']}");
    });
  }

  @override
  Widget build(BuildContext context) {

    return Positioned(
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