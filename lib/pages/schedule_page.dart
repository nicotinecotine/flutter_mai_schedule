import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mai_schedule/my_provider.dart';

class MySchedulePage extends StatelessWidget {
  const MySchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: MyScheduleBottomAppBar(),
      body: ScheduleList(),
    );
  }
}

class MyScheduleBottomAppBar extends StatelessWidget {
  const MyScheduleBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    MyAppProvider state = Provider.of<MyAppProvider>(context);
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: state.themeColorSecond,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 18, bottom: 18),
            child: Text(
              'Обновить',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: state.themeColorFirst,
                  fontSize: 24),
            ),
          ),
          onPressed: () {
            state.firstTimeBuilt(state.didListViewBuild);
            state.fetchData(state.parsedSchedule);
          },
        ),
      ),
    );
  }
}

class ScheduleList extends StatefulWidget {
  const ScheduleList({super.key});

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  @override
  Widget build(BuildContext context) {
    MyAppProvider state = Provider.of<MyAppProvider>(context);
    return ListView(
      scrollDirection: Axis.vertical,
      children: state.parsedSchedule,
    );
  }
}
