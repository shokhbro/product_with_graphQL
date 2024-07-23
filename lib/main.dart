import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lesson_62/config/graphql_config.dart';
import 'package:lesson_62/ui/screens/home_screen.dart';

void main() {
  final client = GraphQLConfig.initializerClient();

  runApp(MainApp(client: client));
}

class MainApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  const MainApp({
    super.key,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: const CacheProvider(
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
  }
}
