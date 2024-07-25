import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract interface class IdentifierComparable {
  dynamic get identifier;
}

/// [DomainEntity] is represented for `Entity` in `Domain Layer`
@immutable
// ignore: must_be_immutable
abstract class DomainEntity<ID> extends Equatable {
  ID? id;

  @override
  List<Object?> get props => [id];

  DomainEntity({this.id});
}

/// Expose [id] for checking equality
abstract class IdComparableEntity<ID> extends DomainEntity<ID>
    implements IdentifierComparable {
  IdComparableEntity({super.id});

  @override
  ID? get identifier => id;
}

typedef StandardEntity = DomainEntity<int>;
typedef StandardIDComparableEntity = IdComparableEntity<int>;
