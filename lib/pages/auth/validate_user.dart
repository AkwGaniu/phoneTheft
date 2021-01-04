import 'package:flutter/material.dart';
import 'dart:io';
import 'package:phonetheft/services/auth.dart';
import 'package:phonetheft/services/models/user.dart';
import 'package:phonetheft/shared/constant.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:camera/camera.dart';
import 'package:phonetheft/services/alert.dart';
import 'package:phonetheft/shared/spinner.dart';



class ValidateUser extends StatefulWidget {
  @override
  _ValidateUserState createState() => _ValidateUserState();
}

class _ValidateUserState extends State<ValidateUser> {
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();
  String password = '';
  CameraController _controller;
  bool loading = false;
  String _error = '';
  // ignore: unused_field
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  File imageFilePath;
  bool _theftDetected = false;
  
  
  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.last;
    _controller = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  Future<void> _snapPicture() async {
    setState(() { _theftDetected = true; });
    try {
      if (_theftDetected) {
        XFile imagePath = await _controller.takePicture();
        setState(() {
          _theftDetected = false;
          imageFilePath = File(imagePath.path);
        });
        return;
      }
    } catch (e) {
      print({'Error  ': e.toString()});
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
      ? _initializeControllerFuture = _controller.initialize()
      // ignore: unnecessary_statements
      : null;
    }
  }
  void dispose() {
    // ignore: todo
    // TODO: dispose
    _controller?.dispose();
    super.dispose();
  }

  void sendMail(String userEmail) async {
    String username = 'ennytech666@gmail.com';
    String password = 'ennytechservices@66';
    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);    
    // Create message.
    final message = Message()
      ..from = Address(username, 'Phone Police')
      ..recipients.add(userEmail)
      ..subject = 'Security Alert'
      ..html ="""
                <div style="width:80%; border-radius:10px; margin:10px auto; background-color:#f5f4f4; padding:10px 20px">
                <h3 style="font-size:20px">Hello, </h3>\n<p style="color:#00303f; font-size:20px">\tWe noticed a theft attempt on your mobile device just now.
                Find attached the picture of the suspect</p>
                <p style="color:#00303f; font-size:20px; margin-top:100px">Thanks.</p>
                </div>
              """
      ..attachments.add(FileAttachment(imageFilePath));
    try {
      print({'Error  hkggghgjg': imageFilePath});
      final sendMailNow = await send(message, smtpServer);
      print('Message sent: ' + sendMailNow.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      print({"Email Error ": e});
    }
  }
    
  @override
  Widget build(BuildContext context) {
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
        Navigator.of(context).pop();
      }
    );
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: _theftDetected ? Column(
            children: [
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return Transform.scale(
                          scale: _controller.value.aspectRatio,
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: CameraPreview(_controller), //cameraPreview
                            ),
                          ));
                } else {
                  return Center(
                  child: CircularProgressIndicator()); // Otherwise, display a loading indicator.
                }
              },
            )
            ],
          )
           : 
          Container(
        padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Verify Identity',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.brown[90]
                ),
              ),
              Text(
                (_error != '') ? _error : '',
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: inputFieldDecoration.copyWith(hintText: 'password'),
                validator: (val) => val.isEmpty ? 'Please provide your password' : null,
                onChanged: (val) {
                  setState(() { password = val.trim(); });
                },
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton.icon(
                      onPressed: (){
                        String title = 'Forgot Password';
                        double height = 180.0;
                        showDialog(
                        context: context,
                        builder: (_) {
                          return SettingsDialog(content: 'forgetPasswod', height: height, title: title, action: button);
                        });
                      },
                      icon: Icon(
                        Icons.help_outline,
                        size: 14.0,
                      ),
                      label: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 12.0
                        ),
                      ),
                      minWidth: 12.0,
                      height: 12.0
                    )
                  ],
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
                    setState(() {
                      _error = '';
                    });
                    dynamic _currentUser = await _auth.getCurrentUser();
                    if (_currentUser == null) {
                      String email = currentuser.email;
                      dynamic _user = await _auth.signInWithEmailAndPassword(email, password);
                      if (_user == null) {
                        setState(() {
                          // _theftDetected = true;
                          _error = 'Incorrect Password';
                        });
                        await _snapPicture();
                        sendMail(email);
                      }
                    } else {
                      setState(() {
                        _error = 'Opps!!! something occured, please try again';
                      });
                      _auth.signOut();
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