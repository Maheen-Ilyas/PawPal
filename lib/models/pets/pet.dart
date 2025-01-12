class Pet {
  final String name;
  final String breed;
  final String gender;
  final String age;
  final String dietryHabit;
  final double weight;

  const Pet({
    required this.name,
    required this.breed,
    required this.gender,
    required this.age,
    required this.dietryHabit,
    required this.weight,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'breed': breed,
      'gender': gender,
      'age': age,
      'dietryHabit': dietryHabit,
      'weight': weight,
    };
  }

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      name: json['name'],
      breed: json['breed'],
      gender: json['gender'],
      age: json['age'],
      dietryHabit: json['dietryHabit'],
      weight: json['weight'],
    );
  }
}
