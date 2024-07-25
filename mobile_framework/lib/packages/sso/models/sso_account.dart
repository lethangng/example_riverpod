import 'package:isar/isar.dart';
import 'package:mobile_framework/packages/api/base/json_codable.dart';
import 'package:mobile_framework/packages/sso/models/s3_sso_domain_builder.dart';

part 'sso_account.g.dart';

@collection
class SSOAccount implements Encodable {
  Id id = Isar.autoIncrement;

  int? userId;

  bool isCurrent = false;

  String? service;

  String? userName;

  String? sessionId;

  bool? isFarmOwner;
  bool? isOwner;

  String? roleName;

  String? roles;

  int? farmId;

  int? facilityId;

  String? accountName;

  bool? isAdmin;

  String? avatar;

  String? status;

  String? email;

  DateTime? birthday;

  String? gender;

  int? enterpriseId;
  int? enterpriseUserId;
  int? fnbId;
  int? fnbUserId;

  @override
  Map<String, dynamic> encode() {
    return {
      "user-id": userId,
      "isCurrent": isCurrent,
      "service": service,
      "username": userName,
      "farm-owner": isFarmOwner,
      "role-name": roleName,
      "is-admin": isAdmin,
      "name": accountName,
      "owner": isOwner,
      "enterprise-id": enterpriseId,
      "enterprise-user-id": enterpriseUserId,
      "fnb-id": fnbId,
      "fnb-user-id": fnbUserId,
      "farm-id": farmId,
      "facility-id": facilityId,
      "avatar": avatar,
      "status": status,
      "email": email,
      "birthDay": birthday?.millisecondsSinceEpoch
    };
  }
}

extension SSOAccountExt on SSOAccount {
  bool get hasFarm => farmId != null;

  bool get hasFacility => facilityId != null;

  void makeCurrent() {
    isCurrent = true;
  }

  void removeCurrent() {
    isCurrent = false;
  }
}

class SSOAccountJWTTokenModel extends SSOAccount implements Decodable {
  @override
  void decode(json) {
    userId = json["user-id"];
    isCurrent = json["isCurrent"] ?? false;
    service = json["service"];
    userName = json["username"];
    roles = json['roles'];
    isFarmOwner = json["farm-owner"];
    roleName = json["role-name"];
    isAdmin = json["is-admin"];
    accountName = json['name'];
    isOwner = json['owner'];
    enterpriseId = json["enterprise-id"];
    enterpriseUserId = json["enterprise-user-id"];

    fnbId = json["fnb-id"];
    fnbUserId = json["fnb-user-id"];

    farmId = json["farm-id"];
    facilityId = json["facility-id"];
    avatar = json['avatar'];
    status = json["status"];
  }
}

class SSOAccountDetailModel extends SSOAccount implements Decodable {
  @override
  void decode(json) {
    userId = json["id"];
    userName = json["username"];
    email = json["email"];
    isAdmin = json["isAdmin"];
    birthday = json['birthDay'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(json['birthDay']);
    gender = json['gender'];
    accountName = json["name"];
    avatar = json['avatar'];
    status = json['status'];
  }
}

extension SSOAcountExts on SSOAccount {
  String get avatarUrl => S3SSODomainBuilder().build() + (avatar ?? "");
}
