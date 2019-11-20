import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:chat_hasura/app/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {
  //dispose will be called automatically by closing its streams
  BehaviorSubject<UserModel> userController = BehaviorSubject<UserModel>();
  @override
  void dispose() {
    userController.close();
    super.dispose();
  }
}
