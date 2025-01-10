import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imusic/components/scaffold_bar.dart';

class SongsDtlPage extends StatefulWidget {
  const SongsDtlPage({super.key});

  @override
  State<SongsDtlPage> createState() => _SongsDtlPageState();
}

class _SongsDtlPageState extends State<SongsDtlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {  // 返回按钮点击事件
              context.pop();
            },
          ),
        ),
        body: const Center(child: Text('哈哈'))
    );
  }
}
