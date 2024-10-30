import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingContainer extends StatelessWidget {
  final double width;
  final double height;

  const LoadingContainer(
      {super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10)),
        ));
  }
}
