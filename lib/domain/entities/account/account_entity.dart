import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  const AccountEntity({
    required this.id,
    required this.username,
    required this.name,
    required this.includeAdult,
  });

  final int id;
  final String username;
  final String name;
  final bool includeAdult;

  @override
  List<Object?> get props => [id, username, name, includeAdult];
}
