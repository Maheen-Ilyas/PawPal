class Complaint {
  final String type;
  final String name;
  final String petName;
  final String breed;
  final String petColor;
  final String lastLocation;
  final String phoneNumber;
  final String reward;

  const Complaint({
    required this.type,
    required this.name,
    required this.petName,
    required this.breed,
    required this.petColor,
    required this.lastLocation,
    required this.phoneNumber,
    required this.reward,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'petName': petName,
      'breed': breed,
      'petColor': petColor,
      'lastLocation': lastLocation,
      'phoneNumber': phoneNumber,
      'reward': reward,
    };
  }

  static Complaint fromJson(Map<String, dynamic> json) {
    return Complaint(
      type: json['type'],
      name: json['name'],
      petName: json['petName'],
      breed: json['breed'],
      petColor: json['petColor'],
      lastLocation: json['lastLocation'],
      phoneNumber: json['phoneNumber'],
      reward: json['reward'],
    );
  }
}
