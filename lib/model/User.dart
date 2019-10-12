import 'package:json_annotation/json_annotation.dart';

/// flutter packages pub run build_runner build
/// flutter packages pub run build_runner build --delete-conflicting-outputs

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'User.g.dart';

@JsonSerializable()
class User{
  User(this.authNumber);

  String authNumber;

  factory User.fromJson(Map<dynamic, dynamic> json) => _$UserFromJson(json);

  Map<dynamic, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{authNumber: $authNumber}';
  }

}