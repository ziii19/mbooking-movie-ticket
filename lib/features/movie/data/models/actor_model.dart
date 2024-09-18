import 'package:mbooking/features/movie/domain/entities/actor.dart';

class ActorModel extends Actor {
  ActorModel({
    required super.id,
    required super.name,
    required super.profilePath,
    required super.job,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'] ?? '',
      job: json['job'] ?? '',
    );
  }
}
