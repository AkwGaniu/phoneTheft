class UserSettings {
  String username;
  String email;
  String password;
  int alarmDelay;
  int detectDelay;
  int alarmTone;
  bool loggedIn;

  UserSettings({
    this.username,
    this.email,
    this.password,
    this.alarmDelay,
    this.detectDelay,
    this.alarmTone,
    this.loggedIn
  });
}

UserSettings user = UserSettings(
  username: '',
  email: '',
  password: '',
  alarmDelay: 0,
  detectDelay: 5,
  alarmTone: 1,
  loggedIn: false
);

bool motionWatchOn = false;
bool chargingWatchOn = false;