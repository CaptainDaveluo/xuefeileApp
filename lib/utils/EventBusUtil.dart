import 'dart:async';

import 'package:event_bus/event_bus.dart';

class EventBusUtil {
  static EventBus _eventBus;

  static EventBus getInstance() {
    if(_eventBus==null){
      _eventBus=EventBus();
    }
    return _eventBus;
  }

  static StreamSubscription<T> listen<T extends Event>(Function(T event) onData) {
    if(_eventBus==null){
      _eventBus=EventBus();
    }
    //内部流属于广播模式，可以有多个订阅者
    return _eventBus.on<T>().listen(onData);
  }

  //发送事件
  static void fire<T extends Event>(T e) {
    if(_eventBus==null){
      _eventBus=EventBus();
    }
    _eventBus.fire(e);
  }
}

abstract class Event {}

class LoginEvent extends Event{
  static int eventIn=1;
  static int eventOut=0;
  final int status;
  LoginEvent(this.status);
}
