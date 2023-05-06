class Lesson {
  final String subject;
  final String type;
  final String time;
  final String location;

  Lesson({
    required this.subject,
    required this.type,
    required this.time,
    required this.location,
  });

  factory Lesson.fromJson(Map<String, String> json) {
    return Lesson(
      subject: json['subject']!,
      type: json['type']!,
      time: json['time']!,
      location: json['location']!,
    );
  }
}

class Day {
  final String name;
  final List<Lesson> lessons;

  Day({
    required this.name,
    required this.lessons,
  });

  factory Day.fromJson(String name, Map<int, Map<String, String>> json) {
    final lessons = <Lesson>[];
    json.forEach((_, value) {
      lessons.add(Lesson.fromJson(value));
    });

    return Day(
      name: name,
      lessons: lessons,
    );
  }
}

class Schedule {
  final List<Day> days;

  Schedule({
    required this.days,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    final days = <Day>[];
    json.forEach((key, value) {
      days.add(Day.fromJson(key, value));
    });

    return Schedule(days: days);
  }
}
