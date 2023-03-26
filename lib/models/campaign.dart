import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'campaign.g.dart';

@Entity()
@JsonSerializable()
class Campaign {
  @Id(assignable: true)
  int? campaignId;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? streetName;
  String? city;
  Map<String, dynamic>? location;
  DateTime? datetimeOrganized;
  String? status;

  Campaign({
    this.name,
    this.location,
    this.datetimeOrganized,
    this.status,
    this.campaignId = 0,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) =>
      _$CampaignFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignToJson(this);
}
