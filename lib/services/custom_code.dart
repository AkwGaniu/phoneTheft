import 'dart:async';
import 'package:sensors/sensors.dart';


// DETECT MOVEMENT AND TRIGGER ALLARM
void detectMovement() async {
  // Future.delayed(Duration(seconds: graceTime * 2), () async {
    StreamSubscription _accelSubscription;
    void _stopAccelerometer() {
      if (_accelSubscription == null) return;
      _accelSubscription.cancel();
      _accelSubscription = null;
    }
    _accelSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.x < -0.1) {
        print(event);
        _stopAccelerometer();

        // TRIGGER THE ALARM HERE
 

        print("Phone was shaked ACCELERO USER");
      }
    });
    print('detector started');
  // });
}

