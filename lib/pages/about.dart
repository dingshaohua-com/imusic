import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('我的')),
        body: Center(
            child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              width: 100,
              height: 20,
              child: Marquee(
                text: '还没做，意不意外😜',
              ),
            ),
          ]),
        )));
  }
}
