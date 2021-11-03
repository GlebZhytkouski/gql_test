import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gql_test/data/schemas/queries/read_accounts.dart' as queries;

class TestService {
  final GraphQLClient qlClient;

  TestService(this.qlClient);

  void getAccounts() async {
    final QueryOptions _options = QueryOptions(
      document: gql(queries.readAccounts),
      fetchPolicy: FetchPolicy.noCache,
      operationName: "readAccounts",
    );

    final result = await qlClient.query(_options);
  }
}
