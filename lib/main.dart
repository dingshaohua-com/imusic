import 'package:flutter/material.dart';
import 'package:imusic/routes/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
* 入口函数
* */
void main() {
  runApp(ProviderScope(child: MaterialApp.router(routerConfig: router)));
}
