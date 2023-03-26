// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_sync_flutter_libs/objectbox_sync_flutter_libs.dart';

import 'models/campaign.dart';
import 'models/user.dart';
import 'models/user_blood_request.dart';
import 'models/user_profile.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(5, 4575754192260502917),
      name: 'UserBloodRequest',
      lastPropertyId: const IdUid(10, 1214329267763511971),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 752129940304305545),
            name: 'requestId',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 8663785083638247950),
            name: 'id',
            type: 9,
            flags: 2080,
            indexId: const IdUid(8, 6119034028548029519)),
        ModelProperty(
            id: const IdUid(3, 8972115319843972293),
            name: 'bloodType',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1097411851300524620),
            name: 'quantity',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 5843733053380486475),
            name: 'urgency',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 7616143536917141837),
            name: 'datetimeRequested',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 3370881801010581777),
            name: 'datetimeDonated',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 4479165376108661859),
            name: 'status',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 1615061297012167590),
            name: 'reqSenderId',
            type: 11,
            flags: 520,
            indexId: const IdUid(9, 6254433066261492559),
            relationTarget: 'User'),
        ModelProperty(
            id: const IdUid(10, 1214329267763511971),
            name: 'reqAccepterId',
            type: 11,
            flags: 520,
            indexId: const IdUid(10, 6095954590913780721),
            relationTarget: 'User')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(6, 1894852297976967627),
      name: 'Campaign',
      lastPropertyId: const IdUid(8, 3782256649042220313),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(2, 5263275051723159909),
            name: 'id',
            type: 9,
            flags: 2080,
            indexId: const IdUid(11, 7661599231403599836)),
        ModelProperty(
            id: const IdUid(3, 8551275897473558228),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 8296139814204827824),
            name: 'datetimeOrganized',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7578367661372787947),
            name: 'status',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3353933053489604310),
            name: 'streetName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 6385286078762087754),
            name: 'city',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 3782256649042220313),
            name: 'campaignId',
            type: 6,
            flags: 129)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(7, 8778808616589042081),
      name: 'UserProfile',
      lastPropertyId: const IdUid(17, 7509422022922875500),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5845877353654234279),
            name: 'profileId',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 1662689414291861755),
            name: 'id',
            type: 9,
            flags: 2080,
            indexId: const IdUid(12, 2541032746187842190)),
        ModelProperty(
            id: const IdUid(3, 6425739437004341098),
            name: 'user',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2744764541918332602),
            name: 'firstName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3788286898368110061),
            name: 'lastName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 7501225107019119963),
            name: 'age',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 4604528559180005972),
            name: 'gender',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 3315976004331003095),
            name: 'bloodType',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5796332151678596847),
            name: 'phoneNumber',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 5430993126989920548),
            name: 'lat',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 3915124378987980814),
            name: 'lon',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 6413790383050678371),
            name: 'streetName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 7554500042606616582),
            name: 'city',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 7709969089003559339),
            name: 'image',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 1871665822331887942),
            name: 'canDonate',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 1296973512819618493),
            name: 'donationRecords',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 7509422022922875500),
            name: 'requestRecords',
            type: 30,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(8, 5101787937838387604),
      name: 'User',
      lastPropertyId: const IdUid(7, 1975071479529247666),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 980794057235199407),
            name: 'userId',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 3421212675336705195),
            name: 'id',
            type: 9,
            flags: 2080,
            indexId: const IdUid(13, 6509528281920968611)),
        ModelProperty(
            id: const IdUid(3, 3381720628382808341),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1076377571933059924),
            name: 'password',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 8118983887603041552),
            name: 'role',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 6595584159415336927),
            name: 'points',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 1975071479529247666),
            name: 'userProfileId',
            type: 11,
            flags: 520,
            indexId: const IdUid(14, 8884226993205880723),
            relationTarget: 'UserProfile')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(8, 5101787937838387604),
      lastIndexId: const IdUid(14, 8884226993205880723),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [
        8544194517871448693,
        8460512837756985394,
        1137632517557213854,
        1872166865235290364
      ],
      retiredIndexUids: const [7986233139448518047],
      retiredPropertyUids: const [
        8246488591931422175,
        4031202032697452451,
        6330979279496071041,
        8240798282819701759,
        2996544000275709090,
        4981576829864996480,
        5538715125602274711,
        7255961167965829358,
        5529528708414186534,
        8587378681321363212,
        2974616441933085043,
        118679371912497750,
        1748523524410044130,
        8099901394594991775,
        8604243851558724926,
        7470934650861620251,
        4414580930999198428,
        378350449138605905,
        7816543195956140229,
        2169401826278425286,
        2068562056663397203,
        8205514879554912030,
        8160849475300297271,
        8797117359845663418,
        3561858106615920567,
        146381589537052951,
        5216666957037387966,
        6860039352339303869,
        5251477940890463112,
        8281233161375896640,
        3705254752945238955,
        2521485212731818956,
        1301857969758971477,
        7960918415776775780,
        5762594848138088952,
        2474489942199915085,
        8116700607968596578,
        7368196004954049991,
        6472017798921433718,
        700344028542316151,
        7595984360941046708,
        3399581983756404782,
        8390954043664868519,
        1273452507218225718,
        3271745635001959357,
        5985166413523065554,
        8051408321553998278
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    UserBloodRequest: EntityDefinition<UserBloodRequest>(
        model: _entities[0],
        toOneRelations: (UserBloodRequest object) =>
            [object.reqSender, object.reqAccepter],
        toManyRelations: (UserBloodRequest object) => {},
        getId: (UserBloodRequest object) => object.requestId,
        setId: (UserBloodRequest object, int id) {
          object.requestId = id;
        },
        objectToFB: (UserBloodRequest object, fb.Builder fbb) {
          final idOffset =
              object.id == null ? null : fbb.writeString(object.id!);
          final bloodTypeOffset = object.bloodType == null
              ? null
              : fbb.writeString(object.bloodType!);
          final urgencyOffset =
              object.urgency == null ? null : fbb.writeString(object.urgency!);
          final datetimeRequestedOffset = object.datetimeRequested == null
              ? null
              : fbb.writeString(object.datetimeRequested!);
          final datetimeDonatedOffset = object.datetimeDonated == null
              ? null
              : fbb.writeString(object.datetimeDonated!);
          final statusOffset =
              object.status == null ? null : fbb.writeString(object.status!);
          fbb.startTable(11);
          fbb.addInt64(0, object.requestId ?? 0);
          fbb.addOffset(1, idOffset);
          fbb.addOffset(2, bloodTypeOffset);
          fbb.addInt64(3, object.quantity);
          fbb.addOffset(4, urgencyOffset);
          fbb.addOffset(5, datetimeRequestedOffset);
          fbb.addOffset(6, datetimeDonatedOffset);
          fbb.addOffset(7, statusOffset);
          fbb.addInt64(8, object.reqSender.targetId);
          fbb.addInt64(9, object.reqAccepter.targetId);
          fbb.finish(fbb.endTable());
          return object.requestId ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = UserBloodRequest(
              id: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              bloodType: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              quantity: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              urgency: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              datetimeRequested: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14),
              datetimeDonated: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 16),
              status: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18),
              requestId: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4));
          object.reqSender.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0);
          object.reqSender.attach(store);
          object.reqAccepter.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 22, 0);
          object.reqAccepter.attach(store);
          return object;
        }),
    Campaign: EntityDefinition<Campaign>(
        model: _entities[1],
        toOneRelations: (Campaign object) => [],
        toManyRelations: (Campaign object) => {},
        getId: (Campaign object) => object.campaignId,
        setId: (Campaign object, int id) {
          object.campaignId = id;
        },
        objectToFB: (Campaign object, fb.Builder fbb) {
          final idOffset =
              object.id == null ? null : fbb.writeString(object.id!);
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final statusOffset =
              object.status == null ? null : fbb.writeString(object.status!);
          final streetNameOffset = object.streetName == null
              ? null
              : fbb.writeString(object.streetName!);
          final cityOffset =
              object.city == null ? null : fbb.writeString(object.city!);
          fbb.startTable(9);
          fbb.addOffset(1, idOffset);
          fbb.addOffset(2, nameOffset);
          fbb.addInt64(3, object.datetimeOrganized?.millisecondsSinceEpoch);
          fbb.addOffset(4, statusOffset);
          fbb.addOffset(5, streetNameOffset);
          fbb.addOffset(6, cityOffset);
          fbb.addInt64(7, object.campaignId ?? 0);
          fbb.finish(fbb.endTable());
          return object.campaignId ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final datetimeOrganizedValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 10);
          final object = Campaign(
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              datetimeOrganized: datetimeOrganizedValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(datetimeOrganizedValue),
              status: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              campaignId: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 18))
            ..id = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 6)
            ..streetName = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 14)
            ..city = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 16);

          return object;
        }),
    UserProfile: EntityDefinition<UserProfile>(
        model: _entities[2],
        toOneRelations: (UserProfile object) => [],
        toManyRelations: (UserProfile object) => {},
        getId: (UserProfile object) => object.profileId,
        setId: (UserProfile object, int id) {
          object.profileId = id;
        },
        objectToFB: (UserProfile object, fb.Builder fbb) {
          final idOffset =
              object.id == null ? null : fbb.writeString(object.id!);
          final userOffset =
              object.user == null ? null : fbb.writeString(object.user!);
          final firstNameOffset = object.firstName == null
              ? null
              : fbb.writeString(object.firstName!);
          final lastNameOffset = object.lastName == null
              ? null
              : fbb.writeString(object.lastName!);
          final genderOffset =
              object.gender == null ? null : fbb.writeString(object.gender!);
          final bloodTypeOffset = object.bloodType == null
              ? null
              : fbb.writeString(object.bloodType!);
          final phoneNumberOffset = object.phoneNumber == null
              ? null
              : fbb.writeString(object.phoneNumber!);
          final streetNameOffset = object.streetName == null
              ? null
              : fbb.writeString(object.streetName!);
          final cityOffset =
              object.city == null ? null : fbb.writeString(object.city!);
          final imageOffset =
              object.image == null ? null : fbb.writeString(object.image!);
          final donationRecordsOffset = object.donationRecords == null
              ? null
              : fbb.writeList(object.donationRecords!
                  .map(fbb.writeString)
                  .toList(growable: false));
          final requestRecordsOffset = object.requestRecords == null
              ? null
              : fbb.writeList(object.requestRecords!
                  .map(fbb.writeString)
                  .toList(growable: false));
          fbb.startTable(18);
          fbb.addInt64(0, object.profileId ?? 0);
          fbb.addOffset(1, idOffset);
          fbb.addOffset(2, userOffset);
          fbb.addOffset(3, firstNameOffset);
          fbb.addOffset(4, lastNameOffset);
          fbb.addInt64(5, object.age);
          fbb.addOffset(6, genderOffset);
          fbb.addOffset(7, bloodTypeOffset);
          fbb.addOffset(8, phoneNumberOffset);
          fbb.addFloat64(9, object.lat);
          fbb.addFloat64(10, object.lon);
          fbb.addOffset(11, streetNameOffset);
          fbb.addOffset(12, cityOffset);
          fbb.addOffset(13, imageOffset);
          fbb.addBool(14, object.canDonate);
          fbb.addOffset(15, donationRecordsOffset);
          fbb.addOffset(16, requestRecordsOffset);
          fbb.finish(fbb.endTable());
          return object.profileId ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = UserProfile(
              id: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              firstName: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              lastName: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              age: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              gender: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 16),
              bloodType: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18),
              phoneNumber: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 20),
              lat: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 22),
              lon: const fb.Float64Reader().vTableGetNullable(buffer, rootOffset, 24),
              streetName: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 26),
              city: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 28),
              image: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 30),
              canDonate: const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 32),
              donationRecords: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false).vTableGetNullable(buffer, rootOffset, 34),
              requestRecords: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false).vTableGetNullable(buffer, rootOffset, 36),
              profileId: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4))
            ..user = const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 8);

          return object;
        }),
    User: EntityDefinition<User>(
        model: _entities[3],
        toOneRelations: (User object) => [object.userProfile],
        toManyRelations: (User object) => {},
        getId: (User object) => object.userId,
        setId: (User object, int id) {
          object.userId = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          final idOffset =
              object.id == null ? null : fbb.writeString(object.id!);
          final emailOffset =
              object.email == null ? null : fbb.writeString(object.email!);
          final passwordOffset = object.password == null
              ? null
              : fbb.writeString(object.password!);
          final roleOffset =
              object.role == null ? null : fbb.writeString(object.role!);
          fbb.startTable(8);
          fbb.addInt64(0, object.userId ?? 0);
          fbb.addOffset(1, idOffset);
          fbb.addOffset(2, emailOffset);
          fbb.addOffset(3, passwordOffset);
          fbb.addOffset(4, roleOffset);
          fbb.addInt64(5, object.points);
          fbb.addInt64(6, object.userProfile.targetId);
          fbb.finish(fbb.endTable());
          return object.userId ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = User(
              id: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              email: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              password: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              role: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              points: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              userId: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4));
          object.userProfile.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0);
          object.userProfile.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [UserBloodRequest] entity fields to define ObjectBox queries.
class UserBloodRequest_ {
  /// see [UserBloodRequest.requestId]
  static final requestId =
      QueryIntegerProperty<UserBloodRequest>(_entities[0].properties[0]);

  /// see [UserBloodRequest.id]
  static final id =
      QueryStringProperty<UserBloodRequest>(_entities[0].properties[1]);

  /// see [UserBloodRequest.bloodType]
  static final bloodType =
      QueryStringProperty<UserBloodRequest>(_entities[0].properties[2]);

  /// see [UserBloodRequest.quantity]
  static final quantity =
      QueryIntegerProperty<UserBloodRequest>(_entities[0].properties[3]);

  /// see [UserBloodRequest.urgency]
  static final urgency =
      QueryStringProperty<UserBloodRequest>(_entities[0].properties[4]);

  /// see [UserBloodRequest.datetimeRequested]
  static final datetimeRequested =
      QueryStringProperty<UserBloodRequest>(_entities[0].properties[5]);

  /// see [UserBloodRequest.datetimeDonated]
  static final datetimeDonated =
      QueryStringProperty<UserBloodRequest>(_entities[0].properties[6]);

  /// see [UserBloodRequest.status]
  static final status =
      QueryStringProperty<UserBloodRequest>(_entities[0].properties[7]);

  /// see [UserBloodRequest.reqSender]
  static final reqSender =
      QueryRelationToOne<UserBloodRequest, User>(_entities[0].properties[8]);

  /// see [UserBloodRequest.reqAccepter]
  static final reqAccepter =
      QueryRelationToOne<UserBloodRequest, User>(_entities[0].properties[9]);
}

/// [Campaign] entity fields to define ObjectBox queries.
class Campaign_ {
  /// see [Campaign.id]
  static final id = QueryStringProperty<Campaign>(_entities[1].properties[0]);

  /// see [Campaign.name]
  static final name = QueryStringProperty<Campaign>(_entities[1].properties[1]);

  /// see [Campaign.datetimeOrganized]
  static final datetimeOrganized =
      QueryIntegerProperty<Campaign>(_entities[1].properties[2]);

  /// see [Campaign.status]
  static final status =
      QueryStringProperty<Campaign>(_entities[1].properties[3]);

  /// see [Campaign.streetName]
  static final streetName =
      QueryStringProperty<Campaign>(_entities[1].properties[4]);

  /// see [Campaign.city]
  static final city = QueryStringProperty<Campaign>(_entities[1].properties[5]);

  /// see [Campaign.campaignId]
  static final campaignId =
      QueryIntegerProperty<Campaign>(_entities[1].properties[6]);
}

/// [UserProfile] entity fields to define ObjectBox queries.
class UserProfile_ {
  /// see [UserProfile.profileId]
  static final profileId =
      QueryIntegerProperty<UserProfile>(_entities[2].properties[0]);

  /// see [UserProfile.id]
  static final id =
      QueryStringProperty<UserProfile>(_entities[2].properties[1]);

  /// see [UserProfile.user]
  static final user =
      QueryStringProperty<UserProfile>(_entities[2].properties[2]);

  /// see [UserProfile.firstName]
  static final firstName =
      QueryStringProperty<UserProfile>(_entities[2].properties[3]);

  /// see [UserProfile.lastName]
  static final lastName =
      QueryStringProperty<UserProfile>(_entities[2].properties[4]);

  /// see [UserProfile.age]
  static final age =
      QueryIntegerProperty<UserProfile>(_entities[2].properties[5]);

  /// see [UserProfile.gender]
  static final gender =
      QueryStringProperty<UserProfile>(_entities[2].properties[6]);

  /// see [UserProfile.bloodType]
  static final bloodType =
      QueryStringProperty<UserProfile>(_entities[2].properties[7]);

  /// see [UserProfile.phoneNumber]
  static final phoneNumber =
      QueryStringProperty<UserProfile>(_entities[2].properties[8]);

  /// see [UserProfile.lat]
  static final lat =
      QueryDoubleProperty<UserProfile>(_entities[2].properties[9]);

  /// see [UserProfile.lon]
  static final lon =
      QueryDoubleProperty<UserProfile>(_entities[2].properties[10]);

  /// see [UserProfile.streetName]
  static final streetName =
      QueryStringProperty<UserProfile>(_entities[2].properties[11]);

  /// see [UserProfile.city]
  static final city =
      QueryStringProperty<UserProfile>(_entities[2].properties[12]);

  /// see [UserProfile.image]
  static final image =
      QueryStringProperty<UserProfile>(_entities[2].properties[13]);

  /// see [UserProfile.canDonate]
  static final canDonate =
      QueryBooleanProperty<UserProfile>(_entities[2].properties[14]);

  /// see [UserProfile.donationRecords]
  static final donationRecords =
      QueryStringVectorProperty<UserProfile>(_entities[2].properties[15]);

  /// see [UserProfile.requestRecords]
  static final requestRecords =
      QueryStringVectorProperty<UserProfile>(_entities[2].properties[16]);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// see [User.userId]
  static final userId = QueryIntegerProperty<User>(_entities[3].properties[0]);

  /// see [User.id]
  static final id = QueryStringProperty<User>(_entities[3].properties[1]);

  /// see [User.email]
  static final email = QueryStringProperty<User>(_entities[3].properties[2]);

  /// see [User.password]
  static final password = QueryStringProperty<User>(_entities[3].properties[3]);

  /// see [User.role]
  static final role = QueryStringProperty<User>(_entities[3].properties[4]);

  /// see [User.points]
  static final points = QueryIntegerProperty<User>(_entities[3].properties[5]);

  /// see [User.userProfile]
  static final userProfile =
      QueryRelationToOne<User, UserProfile>(_entities[3].properties[6]);
}
