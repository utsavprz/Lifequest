import 'package:json_annotation/json_annotation.dart';
import 'package:lifequest/models/hospital.dart';
import 'package:lifequest/models/user.dart';
import 'package:objectbox/objectbox.dart';

part 'user_blood_request.g.dart';

@JsonSerializable()
@Entity()
class UserBloodRequest {
  @Id(assignable: true)
  int? requestId;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? id;
  
  User? user;
  String? bloodType;
  int? quantity;
  Hospital? hospital;
  Map<String, dynamic>? location;
  String? urgency;

  String? datetimeRequested;
  @JsonKey(name: 'donor')

  User? donor;
  String? datetimeDonated;
  String? status;

  final reqSender = ToOne<User>();
  final reqAccepter = ToOne<User>();

  UserBloodRequest(
      {this.id,
      this.user,
      this.bloodType,
      this.quantity,
      this.hospital,
      this.location,
      this.urgency,
      this.datetimeRequested,
      this.donor,
      this.datetimeDonated,
      this.status,
      this.requestId = 0});

  factory UserBloodRequest.fromJson(Map<String, dynamic> json) =>
      _$UserBloodRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserBloodRequestToJson(this);
}
