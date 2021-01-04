class UserSettings {
  String username;
  String email;
  String password;
  int alarmDelay;
  int detectDelay;
  String alarmTone;
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
  alarmTone: '',
  loggedIn: false
);

bool watchOn = false;
