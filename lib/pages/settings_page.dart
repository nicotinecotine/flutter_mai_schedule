import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mai_schedule/data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mai_schedule/my_provider.dart';

class MySettingsPage extends StatelessWidget {
  const MySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SettingsColumn(),
    );
  }
}

class SettingsColumn extends StatefulWidget {
  const SettingsColumn({super.key});

  @override
  State<SettingsColumn> createState() => _SettingsColumnState();
}

class _SettingsColumnState extends State<SettingsColumn> {
  @override
  Widget build(BuildContext context) {
    MyAppProvider state = Provider.of<MyAppProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Группа:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                DropdownButtonFormField(
                  items: groups.map(
                    (group) {
                      return DropdownMenuItem(value: group, child: Text(group));
                    },
                  ).toList(),
                  onChanged: (group) {
                    state.updateSelectedGroup(group!);
                  },
                  value: state.selectedGroup,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Учебная неделя:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                DropdownButtonFormField(
                  items: weeks.map(
                    (week) {
                      return DropdownMenuItem(value: week, child: Text(week));
                    },
                  ).toList(),
                  onChanged: (week) {
                    state.updateSelectedWeek(week!);
                  },
                  value: state.selectedWeek,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Сменить тему:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 6,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoSwitch(
                value: state.isDark,
                activeColor: Colors.indigo,
                onChanged: ((value) {
                  state.changeTheme(state.isDark);
                  if (state.didListViewBuild == true) {
                    state.fetchData(state.parsedSchedule);
                  }
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
