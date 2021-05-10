// import 'package:flutter/material.dart';
import 'package:phonetheft/shared/constant.dart';
import 'package:phonetheft/shared/spinner.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:phonetheft/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String comfirmPassword = '';
  String username = '';
  String _error = '';
  bool loading  = false;
  
  @override
  Widget build(BuildContext context) {
    return loading ? Spin() : Scaffold(
      backgroundColor: Colors.purple[50],
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
                _error,
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 14.0,
                ),
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
              TextFormField(
                obscureText: true,
                decoration: inputFieldDecoration.copyWith(hintText: 'Comfirm Password'),
                validator: (val) => val != password ? 'Password fields does not match' : null,
                onChanged: (val) {
                  setState(() { comfirmPassword = val.trim(); });
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
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _error = "";
                      loading = true;
                    });
                    dynamic user =  await _auth.registerWithEmailAndPassword(email, password);
                    if (user == null) {
                      setState(() {
                        loading = false;
                        _error = "Please Provide valid credentials";
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