import 'package:chat_hasura/app/app_module.dart';
import 'package:chat_hasura/app/app_repository.dart';
import 'package:chat_hasura/app/models/message_model.dart';
import 'package:chat_hasura/app/pages/home/home_bloc.dart';
import 'package:chat_hasura/app/pages/home/home_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageIos extends StatefulWidget {
  final String title;
  const HomePageIos({Key key, this.title = "Chat"}) : super(key: key);

  @override
  _HomePageIosState createState() => _HomePageIosState();
}

class _HomePageIosState extends State<HomePageIos> {
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
      ),
      child: StreamBuilder<List<MessageModel>>(
          stream: messagesOut,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CupertinoActivityIndicator(),
              );
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                          elevation: 0,
                          borderOnForeground: false,
                          margin: EdgeInsets.only(bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(snapshot.data[index].user.name, style: TextStyle(fontSize: 16),),
                              Text(snapshot.data[index].content, style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SafeArea(
                    top: false,
                    child: CupertinoTextField(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: CupertinoColors.lightBackgroundGray
                        )
                      ),
                      controller: bloc.controller,
                      suffix: CupertinoButton(
                        child: Icon(CupertinoIcons.forward),
                        onPressed: bloc.sendMessage,
                      ),
                    ),
                  ),
                  
                ],
              ),
            );
          }),
      
    );
  }
}
