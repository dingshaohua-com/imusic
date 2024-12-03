import 'package:flutter/material.dart';
import 'package:imusic/player.dart';
import 'list.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;  // 当前选中的索引

  // 每个 tab 对应的内容
  final List<Widget> _pages = [
    const Center(child: MyList()),
    Center(child: MyPlayer()),
    const Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Example'),
      ),
      body: _pages[_currentIndex],  // 显示当前选中的页面
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,  // 当前选中的索引
        onTap: (index) {
          setState(() {
            _currentIndex = index;  // 更新当前选中的索引
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}