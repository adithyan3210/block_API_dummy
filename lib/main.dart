import 'package:blocproducts/bloc/products_bloc.dart';
import 'package:blocproducts/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: ProductsPage()));
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductsBloc _productsBloc = ProductsBloc();
  @override
  void initState() {
    _productsBloc.add(GetProductsList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildListProducts(),
    );
  }

  Widget _buildListProducts() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _productsBloc,
        child: BlocListener<ProductsBloc, ProductsState>(
          listener: (context, state) {
            if (state is ProductsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is ProductsInitial) {
                return _buildLoading();
              } else if (state is ProductsLoading) {
                return _buildLoading();
              } else if (state is ProductsLoaded) {
                return _buildCard(context, state.userModel);
              } else if (state is ProductsError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, UserModel model) {
    return ListView.builder(
      itemCount: model.products!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color.fromARGB(255, 196, 193, 193), width: 0.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "NAME: ${model.products![index].title}".toUpperCase(),
              ),
              const SizedBox(height: 10),
              Text(
                " BRAND: ${model.products![index].brand}".toUpperCase(),
              ),
              const SizedBox(height: 10),
              Text(
                "PRICE: ${model.products![index].price}".toUpperCase(),
              ),
              const SizedBox(height: 10),
              Text(
                "STOCK: ${model.products![index].stock}".toUpperCase(),
              ),
              Image.network(model.products![index].images![0].toString()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
