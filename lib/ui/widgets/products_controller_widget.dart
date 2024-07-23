import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lesson_62/data/models/product.dart';

import '../../core/constants/graphql_mutations.dart';

class ProductsControllerWidget {
  static Future<void> addProduct(BuildContext context) async {
    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text;
                final price = int.parse(priceController.text);
                final description = descriptionController.text;

                final data = await GraphQLProvider.of(context).value.mutate(
                      MutationOptions(
                        document: gql(createProduct),
                        variables: {
                          "title": title,
                          "description": description,
                          "categoryId": 1,
                          "price": price,
                          "images": const [
                            'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?cs=srgb&dl=pexels-anjana-c-169994-674010.jpg&fm=jpg'
                          ],
                        },
                        onCompleted: (data) {
                          print(data);
                        },
                        onError: (error) {
                          print(error!.linkException);
                        },
                      ),
                    );
                print(data.data);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> updateProduct(
      BuildContext context, Product product, String id) async {
    final titleController = TextEditingController(text: product.title);
    final priceController =
        TextEditingController(text: product.price.toString());
    final descriptionController =
        TextEditingController(text: product.description);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Product'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text;
                final price = int.parse(priceController.text);
                final description = descriptionController.text;

                await GraphQLProvider.of(context).value.mutate(
                      MutationOptions(
                        document: gql(editProduct),
                        variables: {
                          "id": id,
                          "title": title,
                          "description": description,
                          "price": price,
                        },
                        onCompleted: (data) {
                          print(data);
                        },
                        onError: (error) {
                          print(error!.linkException);
                        },
                      ),
                    );
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> removeProduct(BuildContext context, String id) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Product"),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await GraphQLProvider.of(context).value.mutate(
                      MutationOptions(
                        document: gql(deleteProduct),
                        variables: {"id": id},
                        onCompleted: (data) {
                          print(data);
                        },
                        onError: (error) {
                          print(error!.linkException);
                        },
                      ),
                    );

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
