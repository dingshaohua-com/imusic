import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

// class MusicEventProps{
//   late String type;
//   late String url;
// }

class PlayEvent {
  final Map<String, dynamic> data;
  PlayEvent(this.data);
}


class CustomEvent {
  final Map<String, dynamic> data;
  CustomEvent(this.data);
}
