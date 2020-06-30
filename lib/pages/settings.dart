import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
        color: Colors.purple[300]
    );
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
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
        backgroundColor: Colors.purple[400],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: ListView(
//      mainAxisAlignment: MainAxisAlignment.center,
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

            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Grace time before detection',
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
              onTap: (){ },
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
