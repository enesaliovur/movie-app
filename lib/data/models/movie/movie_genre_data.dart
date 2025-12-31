import 'package:equatable/equatable.dart';

class MovieGenreData extends Equatable {
  const MovieGenreData({required this.id, required this.name});

  factory MovieGenreData.fromMap(Map<String, dynamic> map) {
    return MovieGenreData(id: map['id'] as int, name: map['name'] as String);
  }

  final int id;
  final String name;

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  @override
  List<Object?> get props => [id, name];
}
