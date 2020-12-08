import 'dart:io';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayer/audioplayer.dart';
// import 'package:phonetheft/services/custom_code.dart';
// import 'package:flutter/services.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:phonetheft/shared/userSettings.dart';
import 'package:phonetheft/services/alert.dart';
import 'dart:async';
import 'package:sensors/sensors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneTheft extends StatefulWidget {
  @override
  _PhoneTheftState createState() => _PhoneTheftState();
}

class _PhoneTheftState extends State<PhoneTheft> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        title: Text('Anti Phone Theft'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Settings',
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),

      body: SnackBarWidget(),
    );
  }
}

class SnackBarWidget extends StatefulWidget {
  @override
  _SnackBarWidgetState createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<SnackBarWidget> {
  bool correctPass = false;
  String mp3Uri = '';

  returnSnackBar(msg) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 20.0
        ),
      ),
      backgroundColor: Colors.purple[400],
      duration: Duration(seconds: 5),
    );
    return snackBar;
  }

  void _loadAlarmSoundFile() async {
    final ByteData data = await rootBundle.load('assets/PoliceSirene.mp3');
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/PoliceSirene.mp3');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    SharedPreferences mp3Uri = await SharedPreferences.getInstance();
    await mp3Uri.setString('mp3Uri', tempFile.uri.toString());
  }


  @override
  void initState() {
    super.initState();
    _loadAlarmSoundFile();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
      color: Colors.purple[300]
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'MOTION',
            style: textStyle,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.phone_android,
              color: Colors.purple[500],
              size: 50.0,
            ),
            title: Text(
              'Motion Detection Mode',
              style: TextStyle(
                color: Colors.purple[400]
              ),
            ),
            subtitle: Text(
              watchOn ? 'Motion detection activated' :'Raise alarm when phone move',
              style: TextStyle(
                color: Colors.purple[200],
              ),
            ),
            onTap: () async {
              showDialog(
                context: context,
                builder: (_) {
                  return MyDialog();
                });
              await AndroidAlarmManager.oneShot(Duration(seconds: 10), 0, detectMovement);
            },
          ),
          Divider(
            height: 20.0,
            color: Colors.grey[900],
          ),
          Text(
            'CHARGING',
            style: textStyle,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: (){
              String msg = 'This function is not in place yet';
              final snackBar = returnSnackBar(msg);
              Scaffold.of(context).showSnackBar(snackBar);
            },
            leading: Icon(
              Icons.phone_android,
              color: Colors.purple[500],
              size: 50.0,
            ),
            title: Text(
              'Charging Detection Mode',
              style: TextStyle(
                  color: Colors.purple[400]
              ),
            ),
            subtitle: Text(
              'Raise alarm when device is unplugged',
              style: TextStyle(
                color: Colors.purple[200],
              ),
            ),
          ),
          Divider(
            height: 20.0,
            color: Colors.grey[900],
          ),
          Text(
            'PROXIMITY',
            style: textStyle,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.phone_android,
              color: Colors.purple[500],
              size: 50.0,
            ),
            title: Text(
              'Proximity Detection Mode',
              style: TextStyle(
                  color: Colors.purple[400]
              ),
            ),
            subtitle: Text(
              'Raise alarm when device is removed from pocket',
              style: TextStyle(
                  color: Colors.purple[200],
              ),
            ),
            onTap: (){
              String msg = 'This function is not in place yet';
              final snackBar = returnSnackBar(msg);
              Scaffold.of(context).showSnackBar(snackBar);
            },
          ),
          Divider(
            height: 20.0,
            color: Colors.grey[900],
          ),

        ],
      ),
    );
  }
}


  void _playAlarm() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String mp3Uri =  pref.getString('mp3Uri');
    AudioPlayer player = AudioPlayer();
    player.play(mp3Uri, isLocal: true);
    print('playing....');
  }

// DETECT MOVEMENT AND TRIGGER ALLARM
void detectMovement() async {
  // Future.delayed(Duration(seconds: graceTime * 2), () async {
  StreamSubscription _accelSubscription;
  void _stopAccelerometer() {
    if (_accelSubscription == null) return;
    _accelSubscription.cancel();
    _accelSubscription = null;
  }
  _accelSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
    if (event.x < -0.1) {
      print(event);
      _stopAccelerometer();
      // TRIGGER THE ALARM HERE
      _playAlarm();
      print("Phone was shaked ACCELERO USER");
    }
  });
  print('detector started');
}
