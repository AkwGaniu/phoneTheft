import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonetheft/services/alert.dart';
import 'package:phonetheft/shared/userSettings.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
@override
  Widget build(BuildContext context) {

    int _alarmDelay = user.alarmDelay;
    int _detectDelay = user.detectDelay;

    TextStyle textStyle = TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
      color: Colors.purple[300]
    );

    FlatButton button = FlatButton(
      padding: EdgeInsets.zero,
      child: Text(
        'Ok',
        style: TextStyle(
          color: Colors.purple,
          fontSize: 20.0,
        ),
      ),
      onPressed: () {
        setState(() {
          user.detectDelay = user.detectDelay;
        });
        Navigator.of(context).pop();
      }
    );
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Phone Theft Alarm'),
              SizedBox(height: 3.0,),
              Text(
                'Settings',
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 15.0
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'GRACE TIME',
              style: textStyle,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Grace time before alarm trigger',
                style: TextStyle(
                  color: Colors.purple[400]
                ),
              ),
              subtitle: Text(
                '$_alarmDelay seconds',
                style: TextStyle(
                    color: Colors.purple[200]
                ),
              ),
              onTap: (){
                double height = 340.0;
                String title = 'Grace time before Alarm';
                showDialog(
                  context: context,
                  builder: (_) {
                    return SettingsDialog(content: 'alarm', height: height, title: title, action: button,);
                  }
                );
              },
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Grace time before detection',
                style: TextStyle(
                  color: Colors.purple[400]
                ),
              ),
              subtitle: Text(
                '$_detectDelay seconds',
                style: TextStyle(
                  color: Colors.purple[200]
                ),
              ),
              onTap: (){
                String title = 'Grace time before detection';
                double height = 170.0;
                showDialog(
                context: context,
                builder: (_) {
                  return SettingsDialog(content: 'detect', height: height, title: title, action: button);
                });
              },
            ),
            Divider(
              color: Colors.black,
            ),
            Text(
              'ALARM TONE',
              style: textStyle,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Grace time before alarm trigger',
                style: TextStyle(
                    color: Colors.purple[400]
                ),
              ),
              subtitle: Text(
                '10 seconds',
                style: TextStyle(
                    color: Colors.purple[200]
                ),
              ),
              onTap: (){

              },
            ),
            Divider(
              color: Colors.black,
            ),
            Text(
              'SECURITY',
              style: textStyle,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Change PIN',
                style: TextStyle(
                    color: Colors.purple[400]
                ),
              ),
              subtitle: Text(
                'password',
                style: TextStyle(
                    color: Colors.purple[200]
                ),
              ),
              onTap: (){

              },
            ),
            Divider(
              color: Colors.black,
            ),
            Text(
              'OTHERS',
              style:textStyle,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Questions and Answers',
                style: TextStyle(
                    color: Colors.purple[400]
                ),
              ),
              subtitle: Text(
                'FAQ',
                style: TextStyle(
                    color: Colors.purple[200]
                ),
              ),
              onTap: (){

              },
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
