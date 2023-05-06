import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mai_schedule/my_provider.dart';
import 'package:flutter_mai_schedule/pages/schedule_page.dart';
import 'package:flutter_mai_schedule/pages/settings_page.dart';

class MyMainPage extends StatelessWidget {
  const MyMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: MySchedule(),
    );
  }
}

class MySchedule extends StatelessWidget {
  const MySchedule({super.key});

  @override
  Widget build(BuildContext context) {
    MyAppProvider state = Provider.of<MyAppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Группа: ${state.selectedGroup}; Неделя: ${state.selectedWeek.toLowerCase()}',
          style: TextStyle(color: state.themeColorFirst),
        ),
        bottom: TabBar(
          indicatorColor: state.themeColorFirst,
          tabs: [
            Tab(
              icon: Icon(
                Icons.schedule_outlined,
                color: state.themeColorFirst,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.settings,
                color: state.themeColorFirst,
              ),
            )
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const TabBarView(
        children: [
          MySchedulePage(),
          MySettingsPage(),
        ],
      ),
    );
  }
}
