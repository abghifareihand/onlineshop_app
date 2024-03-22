import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:onlineshop_app/core/components/spaces.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/core/constants/formatter.dart';
import 'package:onlineshop_app/core/constants/images.dart';
import 'package:onlineshop_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:onlineshop_app/presentation/cart/models/product_quantity.dart';

class CartTile extends StatelessWidget {
  final ProductQuantity data;
  const CartTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: AppColors.primary.withOpacity(0.44),
              foregroundColor: AppColors.red,
              icon: Icons.delete_outlined,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(10.0),
              ),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.stroke),
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Image.asset(
                      Images.placeholder,
                      width: 68.0,
                      height: 68.0,
                    ),
                  ),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(10.0),
                  //   child: Image.network(
                  //     data.product.image!.contains('http')
                  //         ? data.product.image!
                  //         : '${Variables.baseUrl}/${data.product.image}',
                  //     width: double.infinity,
                  //     height: 120.0,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  const SpaceWidth(14.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.product.name!,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            data.product.price!.currencyFormatRp,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// button min
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: InkWell(
                      onTap: () {
                        context
                            .read<CartBloc>()
                            .add(CartEvent.removeToCart(data.product));
                      },
                      child: ColoredBox(
                        color: AppColors.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            data.quantity == 1 ? Icons.delete : Icons.remove,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// quantity
                  SizedBox(
                    width: 32,
                    child: Center(child: Text('${data.quantity}')),
                  ),

                  /// button plus
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: InkWell(
                      onTap: () {
                        context
                            .read<CartBloc>()
                            .add(CartEvent.addToCart(data.product));
                      },
                      child: const ColoredBox(
                        color: AppColors.primary,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.add,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
