import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mai_schedule/methods/parsing.dart';
import 'package:flutter_mai_schedule/model/schedule_model.dart';
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
            backgroundColor: state.didUpdateData
                ? const Color.fromARGB(
                    255,
                    211,
                    211,
                    211,
                  )
                : state.themeColorThird,
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
                  color: state.didUpdateData
                      ? Colors.black
                      : state.themeColorFirst,
                  fontSize: 24),
            ),
          ),
          onPressed: () {
            state.download();
          },
        ),
      ),
    );
  }
}

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    MyAppProvider state = Provider.of<MyAppProvider>(context);
    return state.isLoading
        ? FutureBuilder<Schedule>(
            future: fetchSchedule(state.selectedWeek, state.selectedGroup),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.days.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        right: 16,
                        left: 16,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.days[index].name,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(36),
                                  bottomRight: Radius.circular(36),
                                  bottomLeft: Radius.circular(36)),
                              color: state.themeColorSecond,
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  snapshot.data!.days[index].lessons.length,
                              itemBuilder: (context, lessonIndex) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 18,
                                        right: 16,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${snapshot.data!.days[index].lessons[lessonIndex].subject}, ${snapshot.data!.days[index].lessons[lessonIndex].type}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            '${snapshot.data!.days[index].lessons[lessonIndex].time}, ${snapshot.data!.days[index].lessons[lessonIndex].location}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Произошла ошибка: ${snapshot.error}'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: state.themeColorFirst,
                  ),
                );
              }
            }),
          )
        : const Text('');
  }
}
