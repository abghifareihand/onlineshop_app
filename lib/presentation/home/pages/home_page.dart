import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/core/components/search_input.dart';
import 'package:onlineshop_app/core/components/spaces.dart';
import 'package:onlineshop_app/core/constants/images.dart';
import 'package:onlineshop_app/presentation/home/bloc/category/category_bloc.dart';
import 'package:onlineshop_app/presentation/home/widgets/banner_slider.dart';
import 'package:onlineshop_app/presentation/home/widgets/menu_categories.dart';
import 'package:onlineshop_app/presentation/home/widgets/title_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final List<String> banners1 = [
    Images.banner1,
    Images.banner2,
    Images.banner1,
    Images.banner2,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cwb Store'),
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
          const SpaceHeight(16.0),
          BannerSlider(items: banners1),
          const SpaceHeight(12.0),
          TitleContent(
            title: 'Categories',
            onSeeAllTap: () {},
          ),
          const SpaceHeight(12.0),
          const MenuCategories(),
          const SpaceHeight(50.0),
        ],
      ),
    );
  }
}
