import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lesson_62/core/constants/graphql_queries.dart';
import 'package:lesson_62/data/models/product.dart';
import 'package:lesson_62/ui/widgets/products_controller_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  showDialogWidget(Product product) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ProductsControllerWidget.addProduct(context);
                    },
                    label: const Text("Add"),
                    icon: const Icon(Icons.add),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ProductsControllerWidget.updateProduct(
                          context, product, product.id);
                    },
                    label: const Text("Edit"),
                    icon: const Icon(Icons.edit, color: Colors.amber),
                  ),
                ],
              ),
              const Gap(10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ProductsControllerWidget.removeProduct(context, product.id);
                },
                label: const Text("Delete"),
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Home Screen",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(fetchProducts),
        ),
        builder: (
          QueryResult result, {
          VoidCallback? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          List products = result.data!['products'];

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: products.length,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              final product = Product.fromMap(products[index]);
              return Card(
                child: ListTile(
                  onLongPress: () {
                    showDialogWidget(product);
                  },
                  title: Text(product.title),
                  subtitle: Text(product.description),
                  trailing: Text(
                    "${product.price.toString()}\$",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
