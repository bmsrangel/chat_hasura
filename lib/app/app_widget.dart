import 'dart:io';

import 'package:chat_hasura/app/app_bloc.dart';
import 'package:chat_hasura/app/app_module.dart';
import 'package:chat_hasura/app/pages/home/home_module.dart';
import 'package:chat_hasura/app/pages/login/login_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AppModule.to.bloc<AppBloc>();
    if (Platform.isAndroid) {
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
    else {
      return CupertinoApp(
        title: 'Flutter Slidy',
        theme: CupertinoThemeData(
          primaryColor: CupertinoColors.activeBlue,
          scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
        ),
        home: StreamBuilder(
            stream: bloc.userController,
            builder: (context, snapshot) {
              return snapshot.hasData ? HomeModule() : LoginModule();
            }),
      );
    }
  }
}
