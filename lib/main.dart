import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// 应用入口程序
void main() {
  runApp(const MyApp());
}

// 根组件（root  widget）
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const String appTitle = '测试';
    return MaterialApp(
      // 风格类型的根组件
      title: appTitle,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
            backgroundColor: Colors.red,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start, // 让子组件从顶部开始排列
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 150), // 在四个方向上添加 20 的外部间距
                  child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/img/defaut-music.jpg',
                        width: 200, // 设置图片的宽度
                        height: 200, // 设置图片的高度
                      ))),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('歌手: '), Text('周杰伦')],
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: const Text(
                    '七里香',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 160),
                  width: screenWidth * 0.8,
                  height: 2,
                  color: Colors.grey[200]),
              Container(
                margin: const EdgeInsets.only(top: 40),
                width: screenWidth * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,// 内部元素水平居中
                  children: [
                    SvgPicture.asset(
                      'assets/img/player-skip-back.svg',
                      semanticsLabel: 'Dart Logo',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 60),
                    SvgPicture.asset(
                      'assets/img/player-play.svg',
                      semanticsLabel: 'Dart Logo',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 60),
                    SvgPicture.asset(
                      'assets/img/player-skip-forward.svg',
                      semanticsLabel: 'Dart Logo',
                      width: 20,
                      height: 20,
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
