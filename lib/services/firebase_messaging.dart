import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mbap_project_app/main.dart';

class FirebaseApi{
  //Firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //initialize notifications
  Future<void> initNotifications() async{
    //request permission
    await _firebaseMessaging.requestPermission();

    //fetch FCM token
    final fcmTOken = await _firebaseMessaging.getToken();

    //print token
    print('Token: $fcmTOken');
  }

  //handle message
  void handleMessage(RemoteMessage? message){
    if(message == null) return;

    navigatorKey.currentState?.pushNamed('/calendar', arguments: message);
  }

  //initializing background settings
  Future initPushNotifications() async{
    FirebaseMessaging.instance.getInitialMessage().then((value) => handleMessage);
  }
}