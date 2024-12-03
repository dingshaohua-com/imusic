import 'package:flutter/widgets.dart';

// 根组件（root widget）
class MyList extends StatelessWidget {
  const MyList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text( // text widget
      '-----列表页!-----',
      textDirection: TextDirection.ltr,
    );
  }
}