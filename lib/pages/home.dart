import 'package:flutter/material.dart';

class PhoneTheft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey [100],
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        actions: <Widget>[
          IconButton(
            tooltip: 'Settings',
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: Icon(Icons.settings),
          ),
        ],
        title: Text('Anti Phone Theft'),
      ),

      body: SnackBarWidget(),
    );
  }
}


class SnackBarWidget extends StatelessWidget {
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
//      mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'MOTION',
            style: textStyle,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: (){

            },
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
              'Raise alarm when our phone is move',
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
