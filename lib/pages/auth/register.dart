import 'package:flutter/material.dart';
import 'package:phonetheft/shared/constant.dart';
import 'package:phonetheft/shared/spinner.dart';
// import 'package:phonetheft/shared/userSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String username = '';
  String error = '';
  bool loading  = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Spin() : Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        title: Text('Sign Up to Phone Police'),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () {
              widget.toggleView();
            },
            )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                error,
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                decoration: inputFieldDecoration.copyWith(hintText: 'Username'),
                validator: (val) => val.isEmpty ? 'Please give yourself a username' : null,
                onChanged: (val) {
                  setState(() { username = val.trim(); });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: inputFieldDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Please provide a Valid email' : null,
                onChanged: (val) {
                  setState(() { email = val.trim(); });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                decoration: inputFieldDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'Provide a password of 6 chars above' : null,
                onChanged: (val) {
                  setState(() { password = val.trim(); });
                },
              ),
              SizedBox(height: 20.0),
              FlatButton(
                color: Colors.purple[600],
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      error = "";
                      loading = true;
                    });
                    Future.delayed(Duration(seconds: 10), () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('username', username);
                      await prefs.setString('email', email);
                      await prefs.setString('password', password);
                      // user.username = username;
                      // user.email = email;
                      // user.password = password;
                      loading = false;
                      widget.toggleView();
                    });
                    // dynamic user =  await _auth.regWithEmailAndPassword(email, password);
                    // if (user == null) {
                    //   setState(() {
                    //     loading = false;
                    //     error = "Please Provide valid credentials";
                    //   });
                    // }
                  }
                },
              ),
            ],
          ),
          ),
      ),
    );
  }
}