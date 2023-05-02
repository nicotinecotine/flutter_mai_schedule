import 'package:flutter/material.dart';
import 'package:flutter_mai_schedule/methods/building.dart';

class MyAppProvider extends ChangeNotifier {
  bool _didListViewBuilt = false;
  bool _isDark = false;
  String _selectedGroup = 'М8О-101Б-22';
  String _selectedWeek = 'Текущая';
  List<Widget> _parsedSchedule = [];

  bool get isDark => _isDark;
  bool get didListViewBuild => _didListViewBuilt;
  String get selectedGroup => _selectedGroup;
  String get selectedWeek => _selectedWeek;
  List<Widget> get parsedSchedule => _parsedSchedule;
  Color get themeColorFirst => isDark ? Colors.white : Colors.black;
  Color get themeColorSecond => isDark ? Colors.indigo : Colors.yellow;

  void updateSelectedGroup(String selectedGroup) {
    _selectedGroup = selectedGroup;
    notifyListeners();
  }

  void updateSelectedWeek(String selectedGroup) {
    _selectedWeek = selectedGroup;
    notifyListeners();
  }

  void changeTheme(bool isDark) {
    _isDark = !isDark;
    notifyListeners();
  }

  void firstTimeBuilt(bool didFirstTimeBuilt) {
    _didListViewBuilt = true;
    notifyListeners();
  }

  void fetchData(List<Widget> parsedSchedule) async {
    _parsedSchedule = [
      const Center(
          child: Padding(
        padding: EdgeInsets.only(top: 16),
        child: CircularProgressIndicator(),
      ))
    ];
    notifyListeners();
    _parsedSchedule =
        await buildSchedule(_selectedWeek, _selectedGroup, themeColorSecond);
    notifyListeners();
  }
}
