import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../disaster_like_feature/controller/disater_like_controller.dart';
import '../../../models/disaster_model.dart';
import '../../disaster_details/disaster_detail.dart';

class LikePreviewButtons extends StatefulWidget {
  const LikePreviewButtons({
    Key? key,
    required this.likeController,
    required this.disaster,
  }) : super(key: key);

  final LikeController likeController;
  final DisasterModel disaster;

  @override
  _LikePreviewButtonsState createState() => _LikePreviewButtonsState();
}

class _LikePreviewButtonsState extends State<LikePreviewButtons> {
  @override
  void initState() {
    super.initState();
    widget.likeController.updateLikeCount(widget.disaster.id);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              widget.likeController.toggleLike(widget.disaster);
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: widget.likeController.getLikeState(widget.disaster.id).value ? null : TColors.primary,
              minimumSize: const Size(150, 50),
              padding: const EdgeInsets.all(8),
            ),
            icon: Obx(() {
              return Icon(
                widget.likeController.getLikeState(widget.disaster.id).value ? Icons.favorite : Icons.favorite,
                color: widget.likeController.getLikeState(widget.disaster.id).value ? Colors.red : Colors.white,
              );
            }),
            label: Obx(() {
              final bool isLiked = widget.likeController.getLikeState(widget.disaster.id).value;
              final String likeText = isLiked ? 'Unlike (${widget.likeController.likeCount.value})' : 'Like ';
              return Text(
                likeText,
                style: TextStyle(
                  color: isLiked ? Colors.white : null,
                ),
              );
            }),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              Get.to(() => DisasterDetails(disaster: widget.disaster));
            },
            style: TextButton.styleFrom(
              shape: const StadiumBorder(),
              minimumSize: const Size(150, 50),
              padding: const EdgeInsets.all(8),
              backgroundColor: Colors.transparent,
            ),
            child: const Text('Preview'),
          ),
        ],
      ),
    );
  }
}
