import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';
import 'package:flutter_mai_schedule/model/schedule_model.dart';

Future<Schedule> fetchSchedule(String week, String group) async {
  Map<String, Map<int, Map<String, String>>> homeMadeJson = {};
  late http.Response response;

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

  var myHtml = parser.parse(response.body);

  var steps =
      myHtml.querySelector('.step.mb-5')!.querySelectorAll('.step-item');

  List<List<Element>> subjects = [];
  List<Element> days = [];

  for (var content in steps) {
    var dayAndDate = content.querySelector('.step-title');
    var subject = content.querySelectorAll('.mb-4');

    days.add(dayAndDate!);
    subjects.add(subject);
  }

  for (int i = 0; i < days.length; i++) {
    homeMadeJson[days[i].text.trim()] = {};
    for (int j = 1; j < subjects[i].length; j++) {
      String courseName = subjects[i][j].querySelector('p')?.text ?? '';
      String time = subjects[i][j]
              .querySelector('li.list-inline-item:first-child')
              ?.text ??
          '';
      String location = subjects[i][j]
              .querySelector('li.list-inline-item:last-child')
              ?.text ??
          '';

      var lessonName =
          courseName.trim().replaceAll('\n', '').replaceAll('\t', '');

      homeMadeJson[days[i].text.trim()]![j] = {};

      homeMadeJson[days[i].text.trim()]![j]!['subject'] =
          lessonName.substring(0, lessonName.length - 2);
      homeMadeJson[days[i].text.trim()]![j]!['type'] =
          lessonName.substring(lessonName.length - 2, lessonName.length);
      homeMadeJson[days[i].text.trim()]![j]!['time'] = time.trim();
      homeMadeJson[days[i].text.trim()]![j]!['location'] = location.trim();
    }
  }
  return Schedule.fromJson(homeMadeJson);
}
