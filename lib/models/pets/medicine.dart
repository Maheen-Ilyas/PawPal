class Medicine {
  final String petName;
  final String name;
  final int dosage;
  final String frequency;
  final String time;
  final String startDate;
  final String endDate;
  final String instruction;

  const Medicine({
    required this.petName,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.time,
    required this.startDate,
    required this.endDate,
    required this.instruction,
  });

  Map<String, dynamic> toJson() {
    return {
      'petName': petName,
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'time': time,
      'startDate': startDate,
      'endDate': endDate,
      'instruction': instruction,
    };
  }

  static Medicine fromJson(Map<String, dynamic> json) {
    return Medicine(
        petName: json['petName'],
        name: json['name'],
        dosage: json['dosage'],
        frequency: json['frequency'],
        time: json['time'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        instruction: json['instruction']);
  }
}
