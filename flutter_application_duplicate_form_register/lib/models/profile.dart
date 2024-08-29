class Profile {
  int? id;
  late String firstName;
  late String lastName;
  late String email;
  String? imageRef;

    Profile(
      {
      this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.imageRef});

        Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'imageRef': imageRef,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      imageRef: map['imageRef'],
    );
  }
}
