import 'package:flutter/material.dart';
import 'package:imusic/routes/index.dart';
import 'package:imusic/components/player_ball.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
* 入口函数
* */
void main() {
  runApp(MaterialApp.router(
    // routeInformationProvider: router.routeInformationProvider,
    // routeInformationParser: router.routeInformationParser,
    // routerDelegate: router.routerDelegate,
      routerConfig: router
  ));
}

/*
* 根组件
* */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}

/*
* 入口函数
* */
// void main() {
//   // runApp(const ProviderScope(child:
//   //   MyApp()
//   // ));
// }
//
// /*
// * 根组件
// * */
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//   @override
//   MyAppState createState() => MyAppState();
// }
//
// class MyAppState extends State<MyApp> {
//   int currentIndex = 0;
//   void onTap(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: PreferredSize(
//               preferredSize:const Size.fromHeight(30),
//               child: AppBar(
//                 // title: const Text("title"),
//               ),
//             ),
//             // body: Stack(children: [
//             //   _widgetOptions.elementAt(currentIndex),
//             //   const PlayerBall()
//             // ]),
//             // bottomNavigationBar: BottomNavigationBar(
//             //     currentIndex: currentIndex, onTap: onTap, items: _barItems)
//         )
//         );
//   }
// }
