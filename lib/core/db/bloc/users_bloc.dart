// import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends HydratedBloc<UsersEvent, UsersState> {
  UsersBloc() : super(const UsersState(userList: [])) {
    on<UsersEvent>((event, emit) {
      if (event is AddUser) {
        emit(state.copyWith(userList: [...state.userList, event.newUser]));
      } else if (event is RemoveUser) {
        emit(state.copyWith(userList: [...state.userList..removeAt(event.index)]));
      }
    });
  }

  @override
  UsersState fromJson(Map<String, dynamic> json) {
    final userList = List<Map<String, dynamic>>.from(json['userList']);
    return UsersState(userList: userList);
  }

  @override
  Map<String, dynamic> toJson(UsersState state) {
    // final userList = state.userList.map((user) => user.toString()).toList();
    final List<Map<String, dynamic>> userList = state.userList;
    return {'userList': userList};
  }
}
