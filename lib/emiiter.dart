import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class MusicEvent {
  late String str;
  MusicEvent(str);
}
