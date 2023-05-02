// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'users_bloc.dart';

class UsersState extends Equatable {
  final List<String> userList;
  const UsersState({
    this.userList = const [],
  });

  @override
  List<Object> get props => [userList];

  UsersState copyWith({
    List<String>? userList,
  }) {
    return UsersState(
      userList: userList ?? this.userList,
    );
  }
}
