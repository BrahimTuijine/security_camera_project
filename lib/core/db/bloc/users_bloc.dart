import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:security_camera_project/core/db/user.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(const UsersState(userList: [])) {
    on<UsersEvent>((event, emit) async {
      if (event is AddUser) {
        final users = await UserCRUD.addUser(userData: event.newUser);

        emit(state.copyWith(userList: users));
      } else if (event is RemoveUser) {
        final users = await UserCRUD.removeUser(index: event.index);
        emit(state.copyWith(userList: users));
      } else if (event is GetUsers) {
        final users = await UserCRUD.getUsers();

        emit(state.copyWith(userList: users ?? []));
      } else if (event is UpdateUser) {
        final users = await UserCRUD.updateUser(
            index: event.index, newDataUser: event.updatedUser);
        emit(state.copyWith(userList: users));
      }
    });
  }
}
