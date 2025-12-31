import 'package:equatable/equatable.dart';

class Account extends Equatable {
  const Account({
    required this.id,
    required this.username,
    required this.name,
    required this.includeAdult,
  });

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
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

  @override
  List<Object?> get props => [id, username, name, includeAdult];
}
