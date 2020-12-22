import 'dart:async';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:phonetheft/pages/auth/authenticate.dart';
import 'package:phonetheft/shared/userSettings.dart';
import 'package:phonetheft/services/alert.dart';
import 'package:sensors/sensors.dart';
import 'package:local_auth/local_auth.dart';


String name = 'some name';  AudioCache player = AudioCache();
AudioPlayer currentAudioLoop;

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

  @override
  void initState() {
    super.initState();
    // _authenticateUser();
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
              watchOn ? 'Motion detection activated' : 'Raise alarm when phone moves',
              style: TextStyle(
                color: Colors.purple[200],
              ),
            ),
            onTap: () async {
              int graceTime = user.detectDelay;
              showDialog(
                context: context,
                builder: (_) {
                  return MyDialog();
                }
              );
              detectMovement(graceTime);
              // await AndroidAlarmManager.oneShot(Duration(seconds: 2), 0, _authenticateUser);
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
          // Divider(
          //   height: 20.0,
          //   color: Colors.grey[900],
          // ),
          // Text(
          //   'PROXIMITY',
          //   style: textStyle,
          // ),
          // ListTile(
          //   contentPadding: EdgeInsets.zero,
          //   leading: Icon(
          //     Icons.phone_android,
          //     color: Colors.purple[500],
          //     size: 50.0,
          //   ),
          //   title: Text(
          //     'Proximity Detection Mode',
          //     style: TextStyle(
          //         color: Colors.purple[400]
          //     ),
          //   ),
          //   subtitle: Text(
          //     'Raise alarm when device is removed from pocket',
          //     style: TextStyle(
          //         color: Colors.purple[200],
          //     ),
          //   ),
          //   onTap: (){
          //     String msg = 'This function is not in place yet';
          //     final snackBar = returnSnackBar(msg);
          //     Scaffold.of(context).showSnackBar(snackBar);
          //   },
          // ),
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
    player.loop(
      'audio/Police_Siren_3.mp3',
      stayAwake: true,
      volume: 1.0
    ).then((currentPlayer){
      currentAudioLoop = currentPlayer;
    });
  }

  void _authenticateUser() async {
    try {
      var localAuth = LocalAuthentication();
      bool didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to comfirm ownership',
        stickyAuth: true,
        useErrorDialogs: true
      );
      if (didAuthenticate) {
        currentAudioLoop.stop();
        print('Alarm stopped');
      } else {
        print('Alarm continue, You are not the owner');
      }
    } on MissingPluginException catch(e){
      print({'missing plugin error': e});
    } on PlatformException catch(e) {
    //   if (e.code == auth_error.notAvailable) {
    // // Handle this exception here.
    //   }
      // Fluttertoast.showToast(
      //   msg: "Platform Exception for Fingerprint Authentication",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIos: 1,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,
      //   fontSize: 16.0
      // );
      print({'Platform error': e});
    }
  }

  // DETECT MOVEMENT AND TRIGGER ALLARM
  void detectMovement(graceTime) async {
    Future.delayed(Duration(seconds: graceTime * 2), () async {
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
        _playAlarm();
        _authenticateUser();
        print("Phone was shaked ACCELERO USER");
      }
    });
    print('detector started');
  });
}