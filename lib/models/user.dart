import 'package:json_annotation/json_annotation.dart';
import 'package:lifequest/models/user_profile.dart';
import 'package:objectbox/objectbox.dart';

part 'user.g.dart';

@JsonSerializable()
@Entity()
class User {
  // @Unique()
  @Id(assignable: true)
  int? userId;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? id;

  String? email;
  String? password;
  String? role;
  int? points;

  @JsonKey(name: 'profile')
  UserProfile? profile;

  final userProfile = ToOne<UserProfile>();

  User({
    this.id,
    this.email,
    this.password,
    this.role,
    this.profile,
    this.points = 0,
    this.userId = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
