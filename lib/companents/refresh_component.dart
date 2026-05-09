import 'package:flutter/material.dart';

class RefreshComponent extends StatelessWidget {

  final Widget child;
  final ScrollController scrollController;
  final Color? color;
  final Future<void> Function()? onRefresh;
  final ScrollPhysics? physics;
  const RefreshComponent({super.key, required this.child, required this.scrollController, this.onRefresh, this.color, this.physics = const BouncingScrollPhysics()});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: Colors.blue,
        backgroundColor: Colors.white,
        displacement: 40,
        onRefresh: onRefresh ?? () async {},
        child: SingleChildScrollView(
            controller: scrollController,
            physics: physics,
            child: child
        )
    );
  }
}
