import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phonetheft/services/auth.dart';
import 'package:phonetheft/services/models/user.dart';
import 'package:phonetheft/shared/constant.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ValidateUser extends StatefulWidget {
  @override
  _ValidateUserState createState() => _ValidateUserState();
}

class _ValidateUserState extends State<ValidateUser> {
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();
  String password = '';

  sendMail(String userEmail) async {
  String username = 'ennytech666@gmail.com';
  String password = 'ennytechservices@66';

  // ignore: deprecated_member_use
  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server: 
  
  // Create our message.
  final message = Message()
    ..from = Address(username, 'Phone Police')
    ..recipients.add(userEmail)
    ..subject = 'Security Alert'
    ..html = """
                <div style="width:80%; border-radius:10px; margin:10px auto; background-color:#f5f4f4; padding:10px 20px">
                <h3 style="font-size:20px">Hello, </h3>\n<p style="color:#00303f; font-size:20px">\tWe noticed a theft attempt on your mobile device just now.
                Find attached the picture of the suspect</p>
                <p style="color:#00303f; font-size:20px; margin-top:100px">Thanks.</p>
                </div>
             """
    ..attachments = [];

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    print(e);
  }
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: inputFieldDecoration.copyWith(hintText: 'password'),
                validator: (val) => val.isEmpty ? 'Please provide your password' : null,
                onChanged: (val) {
                  setState(() { password = val.trim(); });
                },
              ),
              Container(
                child: IconButton(
                  tooltip: 'Forgot Password',
                  icon: Icon(Icons.help_outline),
                  onPressed: () {

                  }
                )
              ),
              SizedBox(height: 30.0),
              FlatButton(
                color: Colors.purple[600],
                child: Text(
                  'Verify',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic _currentUser = await _auth.getCurrentUser();
                    if (_currentUser == null) {
                      String email = current_user.email;
                      dynamic user = await _auth.signInWithEmailAndPassword(email, password);
                      if (user == null) {
                        sendMail(email);
                      }
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