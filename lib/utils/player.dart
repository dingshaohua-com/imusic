import 'package:fluttertoast/fluttertoast.dart';
import 'package:audioplayers/audioplayers.dart';

class Player {
  // 私有构造函数，确保外部不能直接实例化
  Player._();

  // 内部持有 AudioPlayer 实例
  static final AudioPlayer audioPlayer = AudioPlayer();

  // 使用单例模式，静态实例
  static final Player instance = Player._();

  // 当前的音频源
  late String source;

  // 单例模式的 getInstance 方法，直接返回实例
  static Player getInstance() {
    return instance;
  }

  resume() {
    Player.audioPlayer.resume();
  }

  // 播放音频

  Future<bool> play(String? source) async {
    try {
      await Player.audioPlayer.play(UrlSource(source!));
      return true;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "播放错误：${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP, // 水平和垂直居中
          fontSize: 16.0
      );
      return false;
    }
  }

  pause() {
    Player.audioPlayer.pause();
  }
}
