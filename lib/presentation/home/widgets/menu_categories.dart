import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/core/components/loading.dart';
import 'package:onlineshop_app/core/components/spaces.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/core/constants/images.dart';
import 'package:onlineshop_app/presentation/home/bloc/category/category_bloc.dart';
import 'package:onlineshop_app/presentation/home/widgets/title_content.dart';

class MenuCategories extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllTap;
  const MenuCategories({
    super.key,
    required this.title,
    required this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleContent(
          title: title,
          onSeeAllTap: onSeeAllTap,
        ),
        const SpaceHeight(20.0),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const LoadingSpinkit();
              },
              loaded: (categoryResponse) {
                return Row(
                  children: [
                    ...categoryResponse.data!.map(
                      (category) => Flexible(
                        child: CategoryButton(
                          imagePath: Images.menuFlashsale,
                          label: category.name!,
                          onPressed: () {
                            log(category.name!);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                imagePath,
                width: 80.0,
                height: 80.0,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: medium,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
