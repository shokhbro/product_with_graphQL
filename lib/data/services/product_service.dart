// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:lesson_62/core/constants/graphql_mutations.dart';

// class ProductService {
//   final GraphQLClient client;

//   ProductService(this.client);

//   Future<void> addProduct({
//     required String title,
//     required int price,
//     required String description,
//   }) async {
//     final MutationOptions options = MutationOptions(
//       document: gql(createProduct),
//       variables: {
//         "title": title,
//         "price": price,
//         "description": description,
//       },
//     );

//     final result = await client.mutate(options);

//     if (result.hasException) {
//       print("Error adding product: ${result.exception}");
//     }
//   }

//   Future<void> editProduct({
//     required String id,
//     required String? title,
//     required int? price,
//     required String? description,
//   }) async {
//     final MutationOptions options = MutationOptions(
//       document: gql(updateProduct),
//       variables: {
//         "id": id,
//         "title": title,
//         "price": price,
//         "description": description,
//       },
//       onCompleted: (dynamic resultData) {
//         print(resultData);
//       },
//     );

//     final result = await client.mutate(options);

//     if (result.hasException) {
//       print("Error update product: ${result.exception}");
//     }
//   }

//   Future<void> removeProduct({required String id}) async {
//     final MutationOptions options = MutationOptions(
//       document: gql(deleteProduct),
//       variables: {"id": id},
//       onCompleted: (dynamic resultData) {
//         print(resultData);
//       },
//     );
//     final result = await client.mutate(options);
//     if (result.hasException) {
//       print("Error deleting product: ${result.exception}");
//     }
//   }
// }
