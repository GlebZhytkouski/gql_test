import 'package:flutter/material.dart';
import 'package:gql_test/data/account.dart';
import 'package:gql_test/data/services/test_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Account> accounts = [];

  @override
  void initState() {
    _getAppointments();
    super.initState();
  }

  void _getAppointments() async {
    final HttpLink httpLink = HttpLink(
      'https://test.ca.dev.chr-zephyr.dev/internal-api/graphql',
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer 8fe10a3b3f16df655c57d20b',
    );

    final Link link = authLink.concat(httpLink);
    final testService = TestService(GraphQLClient(cache: GraphQLCache(), link: link));
    final accounts = await testService.getAccounts();
    setState(() {
      if (accounts != null) this.accounts = accounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(100),
          child: ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) =>
                Text("${accounts[index].id} ${accounts[index].city} ${accounts[index].name}"),
            itemCount: accounts.length,
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}
