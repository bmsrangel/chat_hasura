import 'package:chat_hasura/app/app_module.dart';
import 'package:chat_hasura/app/app_repository.dart';
import 'package:chat_hasura/app/models/message_model.dart';
import 'package:chat_hasura/app/pages/home/home_bloc.dart';
import 'package:chat_hasura/app/pages/home/home_module.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var repo = AppModule.to.get<AppRepository>();
  Stream<List<MessageModel>> messagesOut;
  final bloc = HomeModule.to.bloc<HomeBloc>();

  @override
  void initState() {
    messagesOut = repo.getMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<MessageModel>>(
          stream: messagesOut,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index].user.name),
                        subtitle: Text(snapshot.data[index].content),
                      );
                    },
                  ),
                ),
                TextField(
                  controller: bloc.controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: bloc.sendMessage,
                      )),
                ),
              ],
            );
          }),
    );
  }
}
