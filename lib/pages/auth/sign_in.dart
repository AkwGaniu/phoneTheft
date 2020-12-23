import 'package:phonetheft/shared/constant.dart';
import 'package:phonetheft/shared/spinner.dart';
import 'package:flutter/material.dart';
import 'package:phonetheft/services/auth.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;
  final Function logIn;
  SignIn({this.toggleView, this.logIn});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Spin() : Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        title: Text('Sign In to Phone Police'),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign Up'),
            onPressed: () {
              widget.toggleView();
            },
            )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 20.0),
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
                decoration: inputFieldDecoration.copyWith(hintText: 'email'),
                validator: (val) => val.isEmpty ? 'Please provide your email' : null,
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
                  setState(() { password = val; });
                },
              ),
              SizedBox(height: 30.0),
              FlatButton(
                color: Colors.purple[600],
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      error = "";
                      loading = true;
                    });
                    dynamic user =  await _auth.signInWithEmailAndPassword(email, password);
                    if (user == null) {
                      setState(() {
                        loading = false;
                        error = "Oops, Please check your login credentials";
                      });
                    }
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