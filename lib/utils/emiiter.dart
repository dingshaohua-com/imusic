import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

// class MusicEventProps{
//   late String type;
//   late String url;
// }

class MusicEvent {
  final Map<String, dynamic> data;
  MusicEvent(this.data);
}
