import 'package:flutter/material.dart';

class MyAppProvider extends ChangeNotifier {
  bool _isDark = false;
  bool _isLoading = false;
  bool _didUpdateData = false;
  String _selectedGroup = 'М8О-101Б-22';
  String _selectedWeek = 'Текущая';

  bool get isDark => _isDark;
  bool get isLoading => _isLoading;
  bool get didUpdateData => _didUpdateData;
  String get selectedGroup => _selectedGroup;
  String get selectedWeek => _selectedWeek;
  Color get themeColorFirst => _isDark ? Colors.white : Colors.black;
  Color get themeColorSecond => _isDark
      ? Colors.indigo
      : const Color.fromARGB(
          255,
          211,
          211,
          211,
        );
  Color get themeColorThird => _isDark ? Colors.indigo : Colors.yellow;

  void updateSelectedGroup(String selectedGroup) {
    _selectedGroup = selectedGroup;
    notifyListeners();
  }

  void updateSelectedWeek(String selectedWeek) {
    _selectedWeek = selectedWeek;
    notifyListeners();
  }

  void changeTheme() {
    _isDark = !isDark;
    notifyListeners();
  }

  void download() {
    _didUpdateData = true;
    _isLoading = true;
    notifyListeners();
  }

  void undownload() {
    _didUpdateData = false;
    _isLoading = false;
    notifyListeners();
  }
}
