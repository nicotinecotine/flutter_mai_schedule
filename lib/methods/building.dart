import 'package:flutter/material.dart';
import 'package:flutter_mai_schedule/methods/parsing.dart';

Future<List<Widget>> buildSchedule(
    String group, String week, Color cardColor) async {
  List<String> sortedKeys = await getDataFromApi(group, week);
  List<Widget> output = [];

  for (String i in sortedKeys) {
    String title = i;
    List<Widget> myTile = [];

    for (int j = 1; j <= dayCards[i]!.length; j++) {
      String upText = '', downText = '';
      if (dayCards[i]![j]!.length == 4) {
        upText = '${dayCards[i]![j]![0]}, ${dayCards[i]![j]![1]}';
        downText = '${dayCards[i]![j]![2]}, ${dayCards[i]![j]![3]}';
      } else if (dayCards[i]![j]!.length == 5) {
        upText =
            '${dayCards[i]![j]![0]} ${dayCards[i]![j]![1]}, ${dayCards[i]![j]![2]}';
        downText = '${dayCards[i]![j]![3]}, ${dayCards[i]![j]![4]}';
      }
      myTile.add(
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(bottom: 2),
          child: Column(
            children: <Widget>[
              Text(
                upText,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                downText,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
    }
    output.add(
      Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: cardColor,
          ),
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            subtitle: Container(
              padding: const EdgeInsets.only(top: 4, bottom: 2),
              alignment: Alignment.centerLeft,
              child: Column(
                children: myTile,
              ),
            ),
          ),
        ),
      ),
    );
    output.add(const Divider(height: 16, thickness: 0));
  }

  return output;
}
