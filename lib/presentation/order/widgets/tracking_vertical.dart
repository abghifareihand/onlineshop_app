import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/data/models/tracking_response_model.dart';

import '../../../core/components/spaces.dart';
import '../models/track_record_model.dart';

class TrackignVertical extends StatelessWidget {
  final List<Manifest> trackRecords;
  const TrackignVertical({super.key, required this.trackRecords});

  @override
  Widget build(BuildContext context) {
    // final sortedTrackRecords = trackRecords.toList()
    //   ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: trackRecords.length,
      reverse: true,
      itemBuilder: (BuildContext context, int index) => TrackingItem(
        trackRecord: trackRecords[index],
        isCurrent: index == trackRecords.length - 1,
        isLast: index == 0,
      ),
    );
  }
}

class TrackingItem extends StatelessWidget {
  final Manifest trackRecord;
  final bool isCurrent;
  final bool isLast;

  const TrackingItem({
    super.key,
    required this.trackRecord,
    required this.isCurrent,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.0,
          child: Column(
            children: [
              Icon(
                isCurrent ? Icons.radio_button_checked : Icons.circle,
                color: isCurrent
                    ? AppColors.primary
                    : AppColors.grey.withOpacity(0.5),
                size: isCurrent ? 20.0 : 14.0,
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 90.0,
                  color: isCurrent
                      ? AppColors.primary
                      : AppColors.grey.withOpacity(0.5),
                ),
            ],
          ),
        ),
        const SpaceWidth(10.0),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy').format(trackRecord.manifestDate!),
                    style: const TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                  Text(
                    '${trackRecord.manifestTime} WIB',
                    style: const TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  text: '[${trackRecord.manifestCode}] ',
                  children: [
                    TextSpan(
                      text: trackRecord.manifestDescription,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                  style: TextStyle(
                    color: isCurrent
                        ? AppColors.primary
                        : AppColors.grey.withOpacity(0.5),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
