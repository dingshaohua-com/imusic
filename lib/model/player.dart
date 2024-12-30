import 'package:audioplayers/audioplayers.dart';

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

  resume(){
    Player.audioPlayer.resume();
  }

  // 点击播放相关按钮
  Future<void> play(String? source) async {
    await Player.audioPlayer.play(UrlSource(source!));
    // if (source != null) {
    //   this.source = source;
    //
    //   await Player.audioPlayer.resume();
    // } else{
    //   Player.audioPlayer.play();
    // }

  }

  pause(){
    Player.audioPlayer.pause();
  }
}
