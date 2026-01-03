import 'package:boby_ai_case/domain/entities/account/account_entity.dart';
import 'package:equatable/equatable.dart';

class AccountModel extends Equatable {
  const AccountModel({
    required this.id,
    required this.username,
    required this.name,
    required this.includeAdult,
  });

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'] as int? ?? 0,
      username: map['username'] as String? ?? '',
      name: map['name'] as String? ?? '',
      includeAdult: map['include_adult'] as bool? ?? false,
    );
  }

  final int id;
  final String username;
  final String name;
  final bool includeAdult;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'include_adult': includeAdult,
    };
  }

  AccountEntity toEntity() {
    return AccountEntity(
      id: id,
      username: username,
      name: name,
      includeAdult: includeAdult,
    );
  }

  @override
  List<Object?> get props => [id, username, name, includeAdult];
}
