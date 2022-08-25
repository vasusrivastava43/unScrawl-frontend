import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../futures/fetch_student.dart';
import '../screens/screens.dart';

class UserManager extends ChangeNotifier {
  late String _userType;
  late bool _isLoggedIn;

  bool get isLoggedIn => _isLoggedIn;
  String get userType => _userType;

  void checkLogin() {
    final user = FirebaseAuth.instance.currentUser;
    user == null ? _isLoggedIn = false : _isLoggedIn = true;
  }

  Future<void> getUserType() async {
    final preferences = await SharedPreferences.getInstance();
    final userTypeString = preferences.getString('userType');
    userTypeString == 'Teacher' ? _userType = 'Teacher' : _userType = 'Student';
  }

  Future<void> checkStatus(context) async {
    await Future.delayed(Duration(milliseconds: 3000));
    checkLogin();
    await getUserType();

    _isLoggedIn
        ? _userType == 'Teacher'
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: Center(
                      child: TextButton(
                        child: Text('FUTURE WORK - App Restart'),
                        onPressed: () => FirebaseAuth.instance.signOut(),
                      ),
                    ),
                  ),
                ),
              )
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FetchStudent(
                    studentID: FirebaseAuth.instance.currentUser!.uid,
                  ),
                ),
              )
        : Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
  }
}
