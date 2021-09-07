import 'package:meta/meta.dart';

class User {
  final String name;
  final String profileImageUrl;
  final String description;

  const User({
    @required this.name,
    @required this.profileImageUrl,
    @required this.description,
  });
}
