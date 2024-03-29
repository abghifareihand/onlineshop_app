import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/core/components/loading.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/presentation/order/bloc/tracking/tracking_bloc.dart';

import '../../../core/components/spaces.dart';
import '../widgets/tracking_vertical.dart';

class ShippingDetailPage extends StatefulWidget {
  final String resi;
  const ShippingDetailPage({
    super.key,
    required this.resi,
  });

  @override
  State<ShippingDetailPage> createState() => _ShippingDetailPageState();
}

class _ShippingDetailPageState extends State<ShippingDetailPage> {
  @override
  void initState() {
    context
        .read<TrackingBloc>()
        .add(TrackingEvent.getTracking(widget.resi, 'sicepat'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void copyToClipboard(String text) {
      Clipboard.setData(ClipboardData(text: text)).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nomor resi disalin!'),
            duration: Duration(seconds: 1),
            backgroundColor: AppColors.primary,
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengiriman - ${widget.resi}'),
      ),
      body: BlocBuilder<TrackingBloc, TrackingState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const LoadingSpinkitColor();
            },
            loaded: (tracking) {
              if (tracking.rajaongkir!.result!.manifest!.isEmpty) {
                return const Center(
                  child: Text('Data Empty'),
                );
              }
              return ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.stroke),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Text(
                                'No. Resi',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                widget.resi,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.grey,
                                ),
                              ),
                              const SpaceWidth(5.0),
                              InkWell(
                                onTap: () => copyToClipboard(widget.resi),
                                child: const Text(
                                  'SALIN',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.light,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TrackignVertical(
                              trackRecords:
                                  tracking.rajaongkir?.result?.manifest ?? []),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
