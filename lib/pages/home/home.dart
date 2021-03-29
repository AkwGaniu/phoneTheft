import 'dart:async';
// import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
// import 'package:flutter/services.dart';
import 'package:phonetheft/services/auth.dart';
import 'package:phonetheft/services/models/user.dart';
import 'package:phonetheft/shared/userSettings.dart';
import 'package:phonetheft/services/alert.dart';
import 'package:sensors/sensors.dart';
import 'package:battery/battery.dart';


AudioCache player = AudioCache();

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
        title: Text('Phone Police'),
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

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg5.png'),
            fit: BoxFit.cover
          )
        ),
        child: SnackBarWidget()
      ),
    );
  }
}

class SnackBarWidget extends StatefulWidget {

  @override
  _SnackBarWidgetState createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<SnackBarWidget> {
  bool correctPass = false;
  final AuthServices _auth = AuthServices();
  StreamSubscription<BatteryState> _batterySubscription;
  BatteryState _batteryState;
    var _battery = Battery();

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
    _batterySubscription = _battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        _batteryState = state;
      });
    });
  }
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    void _playAlarm() async {
      var loop = player.loop(
        (user.alarmTone == 1) ? 'audio/Police_Sirene.mp3' : 'audio/ambulance.mp3',
        stayAwake: true,
        volume: 1.0
      );
      loop.then((currentPlayer){
        currentuser.currentAudioLoop = currentPlayer;
      });
    }
    // DETECT MOVEMENT AND TRIGGER ALLARM
    void _detectMovement(graceTime) async {
      Future.delayed(Duration(seconds: graceTime * 2), () async {
        setState(() { motionWatchOn = true; });
        StreamSubscription _accelSubscription;
        void _stopAccelerometer() {
          if (_accelSubscription == null) return;
          _accelSubscription.cancel();
          _accelSubscription = null;
        }
      _accelSubscription = accelerometerEvents.listen((AccelerometerEvent event) async {
        if (event.x < -0.1) {
          _stopAccelerometer();
          _playAlarm();
          await _auth.signOut();
          print("Phone was shaked ACCELERO USER");
        }
      });
      print('detector started');
    });
  }

  void _detectectChargingMode (graceTime) async {
    Future.delayed(Duration(seconds: graceTime * 2), () async {
      setState(() { chargingWatchOn = true; });
      if (_batteryState != BatteryState.charging) {
        print({'hi': _batteryState});
        if (_batterySubscription != null) {
          _batterySubscription.cancel();
        }
        _playAlarm();
        await _auth.signOut();
      }
    });
  }

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
              motionWatchOn ? 'Motion detection activated' : 'Raise alarm when phone moves',
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
              _detectMovement(graceTime);
              // await AndroidAlarmManager.oneShot(Duration(seconds: 2), 0, _authenticateUser);
            },
          ),
          Divider(
            height: 20.0,
            color: Colors.grey[400],
          ),
          // Text(
          //   'CHARGING',
          //   style: textStyle,
          // ),
          // ListTile(
          //   contentPadding: EdgeInsets.zero,
          //   onTap: () {
          //     _batterySubscription = _battery.onBatteryStateChanged.listen((BatteryState state) {
          //       setState(() {
          //         _batteryState = state;
          //       });
          //     });
          //     if (_batteryState == BatteryState.discharging) {
          //       String msg = 'Please connect phone to power source';
          //       final snackBar = returnSnackBar(msg);
          //       Scaffold.of(context).showSnackBar(snackBar);
          //       if (_batterySubscription != null) {
          //         _batterySubscription.cancel();
          //       }
          //     } else if (_batteryState == BatteryState.charging) {
          //       int graceTime = user.detectDelay;
          //       showDialog(
          //         context: context,
          //         builder: (_) {
          //           return MyDialog();
          //         }
          //       );
          //       _detectectChargingMode(graceTime);
          //     }
          //   },
          //   leading: Icon(
          //     Icons.phone_android,
          //     color: Colors.purple[500],
          //     size: 50.0,
          //   ),
          //   title: Text(
          //     'Charging Detection Mode',
          //     style: TextStyle(
          //         color: Colors.purple[400]
          //     ),
          //   ),
          //   subtitle: Text(
          //     chargingWatchOn ? 'Charging Detection Mode Activated' : 'Raise alarm when device is unplugged',
          //     style: TextStyle(
          //       color: Colors.purple[200],
          //     ),
          //   ),
          // ),
          // Divider(
          //   height: 20.0,
          //   color: Colors.grey[400],
          // ),
        ],
      ),
    );
  }
}