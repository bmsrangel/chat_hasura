import 'package:chat_hasura/app/app_bloc.dart';
import 'package:chat_hasura/app/app_module.dart';
import 'package:chat_hasura/app/pages/home/home_module.dart';
import 'package:chat_hasura/app/pages/login/login_module.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AppModule.to.bloc<AppBloc>();
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
          stream: bloc.userController,
          builder: (context, snapshot) {
            return snapshot.hasData ? HomeModule() : LoginModule();
          }),
    );
  }
}
