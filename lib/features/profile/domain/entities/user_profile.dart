import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    required this.provider,
    required this.providerId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? avatarUrl;
  final String provider;
  final String? providerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
    id,
    email,
    firstName,
    lastName,
    avatarUrl,
    provider,
    providerId,
    createdAt,
    updatedAt,
  ];
}
