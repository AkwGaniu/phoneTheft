import 'package:flutter/material.dart';
import 'dart:io';
import 'package:phonetheft/services/auth.dart';
import 'package:phonetheft/services/models/user.dart';
import 'package:phonetheft/shared/constant.dart';
import 'package:camera/camera.dart';
import 'package:phonetheft/services/alert.dart';
import 'package:phonetheft/shared/spinner.dart';
import 'package:backendless_sdk/backendless_sdk.dart';

class ValidateUser extends StatefulWidget {
  @override
  _ValidateUserState createState() => _ValidateUserState();
}

class _ValidateUserState extends State<ValidateUser> {
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();
  String password = '';
  CameraController _controller;
  bool _loading = false;
  String _error = '';
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  File imageFilePath;
  String _attachmentPath;
  bool _theftDetected = false;
  // ignore: non_constant_identifier_names
  String APPLICATION_ID = '600F62F2-FFC0-2E76-FFBB-1F6FCA6FEF00';
  // ignore: non_constant_identifier_names
  String ANDROID_API_KEY = '71A514FF-7705-43EE-8C29-F4D7B6DFF019';
  // ignore: non_constant_identifier_names
  String IOS_API_KEY = '659761EA-B660-4F56-AE7D-3E153E2D50E7';
  
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

  Future<File> _snapPicture() async {
    try {
      setState(() { _theftDetected = true; });
      print('dddfdfdfd1');
      XFile imagePath = await _controller.takePicture();
      return File(imagePath.path);
    } catch (e) {
      print({'Camera Error': e.toString()});
      return null;
    }
  }

  Future<String> _uploadImage() {
    Future<String> file = Backendless.files.upload(imageFilePath, "/images");
    return file;
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    Backendless.initApp(APPLICATION_ID, ANDROID_API_KEY, IOS_API_KEY);
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

  void _sendMail(String userEmail) async {
    List<String> recipients = [userEmail];
    // String  _path = _attachmentPath.substring(_attachmentPath.indexOf('images'));
    // List<String> attachments = ['./'+_path];
    // print('something' + _path );
    String mailString = """
                    <div style="width: 100%; background-color:#f5f4f4; padding:10px 0px">
                      <div style="width: 80%; border-radius:10px; margin:10px auto; background-color:#fff; padding:10px 20px">
                        <h3 style="font-size:20px">Hello, </h3>\n
                        <p style="color:#00303f; font-size:20px">\t
                          We noticed a theft attempt on your mobile device just now.
                          Find the picture of the suspect below
                        </p>
                        <div style="width: 90%; padding: 10px 20px">
                          <img src="$_attachmentPath" style="width:100%; height: 100%" alt="Suspect picture"/>
                        </div>
                        <p style="color:#00303f; font-size:20px; margin-top:100px">Thanks.</p>
                      </div>
                    </div>
                  """;
    // BodyParts mailBody = BodyParts('', """
    //                 <div style="width: 100%; background-color:#f5f4f4; padding:10px 0px">
    //                   <div style="width: 80%; border-radius:10px; margin:10px auto; background-color:#fff; padding:10px 20px">
    //                     <h3 style="font-size:20px">Hello, </h3>\n
    //                     <p style="color:#00303f; font-size:20px">\t
    //                       We noticed a theft attempt on your mobile device just now.
    //                       Find the picture of the suspect below
    //                     </p>
    //                     <div style="width: 90%; padding: 10px 20px">
    //                       <img src="$_attachmentPath" style="width:100%; height: 100%" alt="Suspect picture"/>
    //                     </div>
    //                     <p style="color:#00303f; font-size:20px; margin-top:100px">Thanks.</p>
    //                   </div>
    //                 </div>
    //               """);
    // Backendless.messaging.sendEmail("Theft Alert", mailBody, recipients, attachments).then((response) {
    Backendless.messaging.sendHTMLEmail("Theft Alert", mailString, recipients).then((response) {
      print({"Email has been sent": response});
    }).catchError((err) => {
      print({"Response": err.toString()})
    });
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
    return _loading ? Spin() : Scaffold(
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
                          return SettingsDialog(content: 'forgetPassword', height: height, title: title, action: button);
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
                      _loading = true;
                    });
                    dynamic _currentUser = await _auth.getCurrentUser();
                    if (_currentUser == null) {
                      String email = currentuser.email;
                      dynamic _user = await _auth.signInWithEmailAndPassword(email, password);
                      if (_user == null) {
                        setState(() {
                          _loading = false;
                          _error = 'Incorrect Password';
                        });
                        File path = await _snapPicture();
                        setState(() {
                          _theftDetected = false;
                          imageFilePath = path;
                        });
                        String uploadedFilePath = await _uploadImage();
                        setState(() {
                          _attachmentPath = uploadedFilePath;
                        });
                        _sendMail(email);
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