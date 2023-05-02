// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddUser extends UsersEvent {
  final Map<String, dynamic> newUser;
  AddUser({
    required this.newUser,
  });

  @override
  List<Object> get props => [newUser];
}

class RemoveUser extends UsersEvent {
  final int index;
  RemoveUser({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}
