import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:chat_hasura/app/app_bloc.dart';
import 'package:chat_hasura/app/app_module.dart';
import 'package:chat_hasura/app/app_repository.dart';
import 'package:flutter/material.dart';

class LoginBloc extends BlocBase {
  TextEditingController controller = TextEditingController();
  final AppRepository repository;
  final appBloc = AppModule.to.bloc<AppBloc>();

  LoginBloc(this.repository);

  Future<bool> login() async {
    try {
      var user = await repository.getUser(controller.text);
      appBloc.userController.add(user);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
