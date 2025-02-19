import 'package:flutter/material.dart';
import 'package:phonetheft/services/auth.dart';
import 'package:phonetheft/services/models/user.dart';
import 'package:phonetheft/shared/constant.dart';
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
  String _email = '';
  String _msg = '';
  String _error = '';
  TextStyle textStyle = TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
      color: Colors.purple[300]
  );
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();
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

        Column alarmTonePopUp = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RadioListTile<int>(
              title: const Text('Police sirene'),
              value: 1,
              activeColor: Colors.purple,
              selected: user.alarmTone == 1 ? true : false,
              groupValue: user.alarmTone,
              onChanged: (int value) {
                setState(() {
                  user.alarmTone = value;
                });
              },
            ),
            RadioListTile<int>(
              title: const Text('Ambulance'),
              value: 2,
              activeColor: Colors.purple,
              selected: user.alarmTone == 2 ? true : false,
              groupValue: user.alarmTone,
              onChanged: (int value) {
                setState(() {
                  user.alarmTone = value;
                });
              },
            ),
          ],
        );

        Column faqPopUp = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Divider(
              color: Colors.grey[400],
            ),
            Text(
              'How does motion detection mode work?',
              style: textStyle,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 15.0),
              child: Text(
                  'If the device is moved, then theft detection process will be triggered.',
                  style: TextStyle(
                    color: Colors.purple[200],
                  fontSize: 12.0
                  )
              ),
            ),
            Divider(
              color: Colors.grey[400],
            ),
            Text(
              'Does theft detection mode (motion or charging) activate automatically?',
              style: textStyle,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 15.0),
              child: Text(
                  'No, you will have to activate it yourself.',
                  style: TextStyle(
                    color: Colors.purple[200],
                  fontSize: 12.0
                  )
              ),
            ),
            Divider(
              color: Colors.grey[400],
            ),
            Text(
              'How do I know the suspect?',
              style: textStyle,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 15.0),
              child: Text(
                  'Once the system identifies a suspect, a mail with the suspect\'s picture will be sent to your registered email address.',
                  style: TextStyle(
                    color: Colors.purple[200],
                    fontSize: 12.0
                  )
              ),
            ),
            Divider(
              color: Colors.grey[400],
            ),
            // Text(
            //   'How does charging detection mode work?',
            //   style: textStyle,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 15.0),
            //   child: Text(
            //       'If the device is unplugged from power source, then theft detection process will be triggered.',
            //       style: TextStyle(
            //         color: Colors.purple[200],
            //         fontSize: 12.0
            //       )
            //   ),
            // ),
            // Divider(
            //   color: Colors.grey[400],
            // ),
          ],
        );

        Form forgetPassword = Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter email ID',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.brown[90]
                ),
              ),
              Text(
                (_error != '') ? _error : (_msg != '') ? _msg : '',
                style: TextStyle(
                  color: (_msg != '') ? Colors.green[300] : Colors.red[300],
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: inputFieldDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Please provide your email' : null,
                onChanged: (val) {
                  setState(() { _email = val.trim(); });
                },
              ),
              SizedBox(height: 10.0),
              FlatButton(
                color: Colors.purple[600],
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    String userEmail = currentuser.email;
                    if (userEmail == _email) {
                      setState(() {
                        _error = '';
                        _msg = '';
                      });
                      bool sentEmail = await _auth.forgetPassword(_email);
                      if (sentEmail) {
                        setState(() {
                          _email = '';
                          _msg = 'Check your mail for password reset link';
                        });
                      } else {
                        setState(() {
                          _msg = 'Sorry, something occurred. Please try again';
                        });
                      }
                    } else {
                      setState(() {
                        _error = 'Your email address does not exist';
                      });
                    }
                  }
                },
              ),
            ],
          ),
        );
         
        return Container(
          padding: EdgeInsets.all(0.0),
          height: widget.height,
          child: (widget.content == 'alarm')
            ? alarmDelayPopUp
            : (widget.content == 'forgetPassword')
            ? forgetPassword
            : (widget.content == 'faq')
            ? faqPopUp
            : (widget.content == 'alarmTone')
            ? alarmTonePopUp
            : detectDelayPopUp,
        );
      }),
      actions: <Widget>[
        widget.action
      ],
    );
  }
}

