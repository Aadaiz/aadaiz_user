import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/views/my_orders/order_tracking/event_card.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineWidget extends StatelessWidget {

  final bool isFirst;
  final bool isPast;
  final bool isLast;
  final Widget eventCard;

  const TimelineWidget({super.key, required this.isFirst, required this.isPast, required this.isLast, required this.eventCard});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        height: 100,
        child: TimelineTile(
            isFirst: isFirst,
            isLast: isLast,
            beforeLineStyle: const LineStyle(
                color: AppColor.timelineIndicatorColor
            ),
            indicatorStyle: IndicatorStyle(
                width: 40,
                color: AppColor.timelineIndicatorColor,
                iconStyle: IconStyle(
                    iconData: Icons.circle,
                    color: isPast ? AppColor.orangeColor : AppColor.timelineIconColor
                )
            ),
            endChild: EventCard(
                isPast: isPast,
                child: eventCard
            )
        )
    );

  }

}