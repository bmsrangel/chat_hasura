import 'package:chat_hasura/app/pages/login/login_bloc.dart';
import 'package:chat_hasura/app/pages/login/login_module.dart';
import 'package:flutter/cupertino.dart';

class LoginPageIos extends StatefulWidget {
  final String title;
  const LoginPageIos({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageIosState createState() => _LoginPageIosState();
}

class _LoginPageIosState extends State<LoginPageIos> {
  final bloc = LoginModule.to.bloc<LoginBloc>();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoTextField(
              controller: bloc.controller,
              placeholder: "Nickname",
            ),
            CupertinoButton(
              child: Text("Acessar"),
              onPressed: () {
                bloc.login();
              },
            )
          ],
        ),
      ),
    );
  }
}
