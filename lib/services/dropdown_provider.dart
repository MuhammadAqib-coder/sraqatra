import 'package:flutter/cupertino.dart';

class DropdownProvider extends ChangeNotifier {
  String _bloodGroup = 'blood group';
  String _gender = 'gender';
  int _currentIndex = 1;
  bool _password = true;
  bool _confirmPass = true;
  String _search = '';

  String get bloodGroup {
    return _bloodGroup;
  }

  String get gender {
    return _gender;
  }

  int get currentIndex {
    return _currentIndex;
  }

  bool get password {
    return _password;
  }

  bool get confirmPass {
    return _confirmPass;
  }

  String get search {
    return _search;
  }

  void setBloodgroup(value) {
    _bloodGroup = value;
    notifyListeners();
  }

  void setGender(value) {
    _gender = value;
    notifyListeners();
  }

  void setCurrentIndex(index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setPassword(value) {
    _password = value;
    notifyListeners();
  }

  void setConfirmPass(value) {
    _confirmPass = value;
    notifyListeners();
  }

  void setSearch(value) {
    _search = value;
    notifyListeners();
  }
}
