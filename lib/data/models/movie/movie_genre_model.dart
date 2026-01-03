import 'package:equatable/equatable.dart';

class MovieGenreModel extends Equatable {
  const MovieGenreModel({required this.id, required this.name});

  factory MovieGenreModel.fromMap(Map<String, dynamic> map) {
    return MovieGenreModel(id: map['id'] as int, name: map['name'] as String);
  }

  final int id;
  final String name;

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  @override
  List<Object?> get props => [id, name];
}
