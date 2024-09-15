
class User {
  final String uid;
  final String name;
  final String email;
  final num? phoneNumber;
  final String? photoUrl;

  User({
    required this.uid,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.photoUrl,
  });

}
