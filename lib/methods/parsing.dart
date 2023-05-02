import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:flutter_mai_schedule/data.dart';

Map<String, Map<int, List<String>>> dayCards = {};
late http.Response response;

Future<List<String>> getDataFromApi(String week, String group) async {
  if (week == 'Текущая') {
    try {
      response = await http.get(Uri.parse(
          'https://mai.ru/education/studies/schedule/index.php?group=$group'));
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  } else {
    int rightWeek = 0;
    rightWeek = int.parse(week.split(' ')[0].replaceAll('.', ''));
    try {
      response = await http.get(Uri.parse(
          'https://mai.ru/education/studies/schedule/index.php?group=$group&week=$rightWeek'));
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  }

  dayCards = {};

  final document = parser.parse(response.body);

  final classElements = document.querySelectorAll('.step.mb-5');

  final classEntities = classElements.map((element) {
    final text = element.text.trim();

    final parts = text.split('\n').map((part) => part.trim()).toList();

    final nonEmptyParts = parts.where((part) => part.isNotEmpty).toList();

    return nonEmptyParts;
  }).toList();

  List<String> parsedSchedule = classEntities[0];

  RegExp datePattern = RegExp(r"^[А-Яа-я]{2},\s+\d{2}\s+[А-Яа-я]+");
  RegExp fullName = RegExp(r'^[А-ЯЁ][а-яё]*\s[А-ЯЁ][а-яё]*\s[А-ЯЁ][а-яё]*$');

  String dayNow = '';
  int cnt = 1;

  for (int i = 0; i < parsedSchedule.length; i++) {
    if (datePattern.hasMatch(parsedSchedule[i])) {
      dayCards[parsedSchedule[i]] = {};
      dayNow = parsedSchedule[i];
      cnt = 1;
    } else {
      if (!dayCards[dayNow]!.containsKey(cnt)) {
        dayCards[dayNow]![cnt] = [];
        dayCards[dayNow]![cnt]!.add(parsedSchedule[i]);
      } else if (ifClassroom(parsedSchedule[i])) {
        if (i < parsedSchedule.length - 1 &&
            !ifClassroom(parsedSchedule[i + 1])) {
          dayCards[dayNow]![cnt]!.add(parsedSchedule[i]);
          cnt += 1;
        } else {
          continue;
        }
      } else if (fullName.hasMatch(parsedSchedule[i]) ||
          parsedSchedule[i].split(' ')[0] == 'Бояр-созонович') {
        continue;
      } else {
        dayCards[dayNow]![cnt]!.add(parsedSchedule[i]);
      }
    }
  }
  return dayCards.keys.toList();
}
