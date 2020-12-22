import 'package:flutter/material.dart';
import 'package:phonetheft/shared/userSettings.dart';

class MyDialog extends StatefulWidget {
    @override
      _MyDialogState createState() => new _MyDialogState();
}
class _MyDialogState extends State<MyDialog> {
  @override
  void initState() {
    countDown(user.detectDelay);
    super.initState();
  }
  int _detectDelay = user.detectDelay;
  // Color _c = Colors.redAccent;
  bool actionBtn = false;
  String title = "Please keep the device down";
  double height = 30.0;
  void countDown(num) async {
    setState((){
      _detectDelay = user.detectDelay;
    });
    for (int i=0; i<=num; i++) {
      await Future.delayed(Duration(seconds: 2), (){
        setState((){
          _detectDelay = _detectDelay - 1;
        });
      });
      if (_detectDelay < 0) {
        setState(() {
          watchOn = true;
        });
        Navigator.pop(context);
        _detectDelay = num;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.purple[200]
        ),
      ),
      content: StatefulBuilder(  // You need this, notice the parameters below:
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.all(0.0),
            height: height,
            child: Center(
              child: Text(
              '$_detectDelay',
              style: TextStyle(
                color: Colors.purple[500],
                fontSize: 30.0,
              ),
              )
            ),
          );
      }),
      actions: actionBtn ? <Widget>[
        FlatButton(
          padding: EdgeInsets.zero,
            child: Text(
              'Ok',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ] : <Widget>[],
    );
  }
}

class SettingsDialog extends StatefulWidget {
  final String title;
  final double height;
  final String content;
  final FlatButton action;
  SettingsDialog({this.content, this.height, this.title, this.action});

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}
class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        style: TextStyle(
          color: Colors.purple[200]
        ),
      ),
      content: StatefulBuilder(  // You need this, notice the parameters below:
        builder: (BuildContext context, StateSetter setState) {
          
        Column alarmDelayPopUp = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RadioListTile<int>(
              title: const Text('0 second'),
              value: 0,
              groupValue: user.alarmDelay,
              activeColor: Colors.purple,
              selected: user.alarmDelay == 0 ? true : false,
              onChanged: (int value) {
                setState(() {
                  user.alarmDelay = value;
                });
              },
            ),
            RadioListTile<int>(
              title: const Text('1 second'),
              value: 1,
              groupValue: user.alarmDelay,
              activeColor: Colors.purple,
              selected: user.alarmDelay == 1 ? true : false,
              onChanged: (int value) {
                setState(() {
                  user.alarmDelay = value;
                });
              },
            ),
            RadioListTile<int>(
              title: const Text('2 Seconds'),
              value: 2,
              activeColor: Colors.purple,
              selected: user.alarmDelay == 2 ? true : false,
              groupValue: user.alarmDelay,
              onChanged: (int value) {
                setState(() {
                  user.alarmDelay = value;
                });
              },
            ),
            RadioListTile<int>(
              title: const Text('3 Seconds'),
              value: 3,
              activeColor: Colors.purple,
              selected: user.alarmDelay == 3 ? true : false,
              groupValue: user.alarmDelay,
              onChanged: (int value) {
                setState(() {
                  user.alarmDelay = value;
                });
              },
            ),
            RadioListTile<int>(
              title: const Text('4 Seconds'),
              value: 4,
              activeColor: Colors.purple,
              selected: user.alarmDelay == 4 ? true : false,
              groupValue: user.alarmDelay,
              onChanged: (int value) {
                setState(() {
                  user.alarmDelay = value;
                });
              },
            ),
            RadioListTile<int>(
              title: const Text('5 Seconds'),
              value: 5,
              activeColor: Colors.purple,
              selected: user.alarmDelay == 5 ? true : false,
              groupValue: user.alarmDelay,
              onChanged: (int value) {
                setState(() {
                  user.alarmDelay = value;
                });
              },
            ),
          ],
        );

        Column detectDelayPopUp = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RadioListTile<int>(
              title: const Text('5 Seconds'),
              value: 5,
              activeColor: Colors.purple,
              selected: user.detectDelay == 5 ? true : false,
              groupValue: user.detectDelay,
              onChanged: (int value) {
                setState(() {
                  user.detectDelay = value;
                });
              },
            ),
            RadioListTile<int>(
              title: const Text('10 Seconds'),
              value: 10,
              activeColor: Colors.purple,
              selected: user.detectDelay == 10 ? true : false,
              groupValue: user.detectDelay,
              onChanged: (int value) {
                setState(() {
                  user.detectDelay = value;
                });
              },
            ),
            RadioListTile<int>(
              title: const Text('15 Seconds'),
              value: 15,
              activeColor: Colors.purple,
              selected: user.detectDelay == 15 ? true : false,
              groupValue: user.detectDelay,
              onChanged: (int value) {
                setState(() {
                  user.detectDelay = value;
                });
              },
            ),
          ],
        );
        
        return Container(
          padding: EdgeInsets.all(0.0),
          height: widget.height,
          child: widget.content == 'alarm' ? alarmDelayPopUp : detectDelayPopUp,
        );
      }),
      actions: <Widget>[
        widget.action
      ],
    );
  }
}

