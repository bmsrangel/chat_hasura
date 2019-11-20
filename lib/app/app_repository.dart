import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:chat_hasura/app/models/message_model.dart';
import 'package:chat_hasura/app/models/user_model.dart';
import 'package:hasura_connect/hasura_connect.dart';

class AppRepository extends Disposable {
  final HasuraConnect connection;

  AppRepository(this.connection);

  Future<UserModel> getUser(String user) async {
    var query = """
      getUser(\$name:String!){
        users(where: {name: {_eq: \$name}}) {
          name
          id
        }
      }
    """;

    var data = await connection.query(query, variables: {"name": user});
    if (data["data"]["users"].isEmpty) {
      //Criar mutation
      return createUser(user);
    } else {
      return UserModel.fromJson(data["data"]["users"][0]);
    }
  }

  Future<UserModel> createUser(String name) async {
    var query = """
      createUser(\$name:String!) {
        insert_users(objects: {name: \$name}) {
          returning {
            id
          }
        }
      }
    """;
    var data = await connection.mutation(query, variables: {"name": name});
    var id = data["data"]["insert_users"]["returning"][0]["id"];
    return UserModel(id: id, name: name);
  }

  Stream<List<MessageModel>> getMessages() {
    var query = """
      subscription {
        messages(order_by: {id: desc}) {
          content
          id
          user {
            id
            name
          }
        }
      }
    """;

    Snapshot snapshot = connection.subscription(query);
    return snapshot.stream
        .map((jsonList) => MessageModel.fromJsonList(jsonList["data"]["messages"]));
  }

  Future<dynamic> sendMessage(String message, int userId) {
    var query = """
      sendMessage(\$message:String!, \$userId:Int!) {
        insert_messages(objects: {content: \$message, id_user: \$userId}) {
          affected_rows
        }
      }
    """;
    return connection.mutation(query, variables: {"message": message, "userId": userId});
  }

  @override
  void dispose() {}
}
