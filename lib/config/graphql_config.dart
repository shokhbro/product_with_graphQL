import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink("https://api.escuelajs.co/graphql");

  static ValueNotifier<GraphQLClient> initializerClient() {
    final Link link = httpLink;
    return ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: link,
      ),
    );
  }
}
