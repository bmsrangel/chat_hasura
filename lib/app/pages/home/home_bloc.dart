import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:chat_hasura/app/app_bloc.dart';
import 'package:chat_hasura/app/app_module.dart';
import 'package:chat_hasura/app/app_repository.dart';
import 'package:flutter/cupertino.dart';

class HomeBloc extends BlocBase {
  TextEditingController controller = TextEditingController();
  var repo = AppModule.to.get<AppRepository>();
  final appBloc = AppModule.to.bloc<AppBloc>();

  void sendMessage() {
    repo.sendMessage(
      controller.text,
      appBloc.userController.value.id,
    );
    controller.clear();
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
