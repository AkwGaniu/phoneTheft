import 'package:audioplayers/audioplayers.dart';

class User {
  final String uid;
  final String email;
  User({this.uid, this.email });
}

class CurrentUser {
  String email;
  dynamic currentAudioLoop;

  CurrentUser({ this.email, this.currentAudioLoop });
}

CurrentUser current_user = CurrentUser(
  email: '',
  currentAudioLoop: ''
);