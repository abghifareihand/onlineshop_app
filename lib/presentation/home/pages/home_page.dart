import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/core/components/loading.dart';
import 'package:onlineshop_app/core/components/search_input.dart';
import 'package:onlineshop_app/core/components/spaces.dart';
import 'package:onlineshop_app/presentation/home/bloc/category/category_bloc.dart';
import 'package:onlineshop_app/presentation/home/bloc/product/product_bloc.dart';
import 'package:onlineshop_app/presentation/home/bloc/product_category/product_category_bloc.dart';
import 'package:onlineshop_app/presentation/home/widgets/banner_slider.dart';
import 'package:onlineshop_app/presentation/home/widgets/list_product.dart';
import 'package:onlineshop_app/presentation/home/widgets/menu_categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(const ProductEvent.getProducts());
    context.read<CategoryBloc>().add(const CategoryEvent.getCategories());
    context
        .read<ProductCategoryBloc>()
        .add(const ProductCategoryEvent.getProductByCategory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goy Store'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SearchInput(),
          const BannerSlider(),
          MenuCategories(
            title: 'Categories',
            onSeeAllTap: () {},
          ),
          const SpaceHeight(50.0),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const LoadingSpinkit();
                },
                loaded: (productResponse) {
                  return ListProduct(
                    title: 'All Product',
                    onSeeAllTap: () {},
                    items: productResponse.data!.data!.take(2).toList(),
                  );
                },
              );
            },
          ),
          const SpaceHeight(20.0),
          BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const LoadingSpinkit();
                },
                loaded: (productResponse) {
                  return ListProduct(
                    title: 'Best Seller',
                    onSeeAllTap: () {},
                    items: productResponse.data!.data!,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
