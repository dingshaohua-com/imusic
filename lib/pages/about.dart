import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的')),
      body: Center(child:  SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            width: 100,
            height: 20,
            child: Marquee(
              text: '1234567890',
            ),
          ),
        ]
        ),
      )
    )
    );




    // return Container(
    //     width: double.infinity,
    //     height: double.infinity,
    //     color: Colors.red, // 给 Container 设置背景色
    //     child: SingleChildScrollView(
    //       child: Column(children: [
    //         SizedBox(
    //           width: 100,
    //           height: 20,
    //           child: Marquee(
    //             text: 'There once was a boy who told this story about a boy: "',
    //           ),
    //         ),
    //       ]),
    //     ));
  }
}
