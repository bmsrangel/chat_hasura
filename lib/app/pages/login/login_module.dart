import 'dart:io';

import 'package:chat_hasura/app/app_module.dart';
import 'package:chat_hasura/app/app_repository.dart';
import 'package:chat_hasura/app/pages/login/login_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:chat_hasura/app/pages/login/login_page_ios.dart';
import 'package:flutter/material.dart';
import 'package:chat_hasura/app/pages/login/login_page.dart';

class LoginModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => LoginBloc(AppModule.to.get<AppRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => Platform.isAndroid ? LoginPage() : LoginPageIos();

  static Inject get to => Inject<LoginModule>.of();
}
