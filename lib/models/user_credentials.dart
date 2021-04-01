class UserCredentials {
  final double height;
  final double weight;
  final String birthday;
  final String name;
  final String surname;
  final String gender;
  final int motivation;
  //final String id;

  const UserCredentials({
    required this.birthday,
    required this.gender,
    required this.height,
    required this.motivation,
    required this.name,
    required this.surname,
    required this.weight,
  });

  factory UserCredentials.fromJson(Map<String, dynamic> json) => UserCredentials(
        //id: json["id"],
        birthday: json["birthday"],
        gender: json["gender"],
        surname: json["surname"],
        motivation: json["motivation"],
        name: json["name"],
        weight: json["weight"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "birthday": birthday,
        "gender": gender,
        "surname": surname,
        "motivation": motivation,
        "name": name,
        "weight": weight,
        "height": height,
      };
}
