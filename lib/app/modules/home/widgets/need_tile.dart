import 'package:flutter/material.dart';

import '../../../../helpers/theme/text_styles.dart';
import '../../../../helpers/theme/ui_helpers.dart';
import '../../models/need.dart';

class NeedTile extends StatelessWidget {
  final Need need;
  final Function deleteNeed;
  const NeedTile({Key? key, required this.need, required this.deleteNeed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.notification_add_outlined,
          size: 40,
        ),
        horizontalSpaceSmall,
        Text(
          need.title,
          style: headingBoldStyle,
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            deleteNeed(need.id);
          },
          icon: Icon(
            Icons.remove_circle_outline,
            size: 40,
          ),
        ),
      ],
    );
  }
}
