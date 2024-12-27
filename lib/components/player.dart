import 'package:audioplayers/audioplayers.dart';
import 'package:imusic/utils/emiiter.dart';

class Player  {

  // 私有构造函数，确保外部不能直接实例化
  Player._();


  // 内部持有 AudioPlayer 实例
  static final AudioPlayer audioPlayer = AudioPlayer();

  // 使用单例模式，静态实例
  static final Player instance = Player._();

  // 当前的音频源
  late String source ;

  // 单例模式的 getInstance 方法，直接返回实例
  static Player getInstance() {
    return instance;
  }

  // 点击播放相关按钮
  Future<void> play(String? source) async {
    if (source != null) {
      this.source = source;
    }
    await Player.audioPlayer.setSource(UrlSource(source!));
    await Player.audioPlayer.resume();
  }

  // 订阅事件
  void subscribe() {
    eventBus.on<PlayEvent>().listen((event) {
      print('Received play event: ${event}');
      // 你可以在这里处理接收到的事件，比如更新 UI 或进行其他操作
    });
  }
}
