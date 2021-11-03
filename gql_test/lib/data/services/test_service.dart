import 'package:gql_test/data/account.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gql_test/data/schemas/queries/read_accounts.dart' as queries;

class TestService {
  final GraphQLClient qlClient;

  TestService(this.qlClient);

  Future<List<Account>?> getAccounts() async {
    final QueryOptions _options = QueryOptions(
      document: gql(queries.readAccounts),
      fetchPolicy: FetchPolicy.noCache,
      operationName: "readAccounts",
    );

    final result = await qlClient.query(_options);
    print(result);
    if (result.data != null) {
      final edges = result.data!["accounts"]["edges"] as List;
      return edges.map((e) {
        return Account.fromJson(e["node"] as Map<String, dynamic>);
      }).toList();
    }
    return null;
  }
}
