import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/core/constants/formatter.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/data/models/history_order_response_model.dart';
import 'package:onlineshop_app/presentation/order/widgets/row_text.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';

class OrderCard extends StatelessWidget {
  final HistoryOrder data;
  const OrderCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          RouteName.trackingOrder,
          extra: data.id,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NO RESI: ${data.shippingResi ?? '-'}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Button.filled(
                  onPressed: () {},
                  label: 'Lacak',
                  height: 20.0,
                  width: 94.0,
                  fontSize: 11.0,
                ),
              ],
            ),
            const SpaceHeight(24.0),
            RowText(label: 'Status', value: data.status ?? '-'),
            const SpaceHeight(12.0),
            RowText(
                label: 'Total Harga', value: data.totalCost!.currencyFormatRp),
          ],
        ),
      ),
    );
  }
}
