import 'package:flutter/material.dart';

import 'loading_container.dart';

class NewsTileLoading extends StatelessWidget {
  const NewsTileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LoadingContainer(
              width: 120,
              height: 120,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const LoadingContainer(width: 30, height: 30),
                      const SizedBox(
                        width: 10,
                      ),
                      LoadingContainer(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 20)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LoadingContainer(
                      width: MediaQuery.of(context).size.width / 2, height: 30),
                  const SizedBox(
                    height: 10,
                  ),
                  LoadingContainer(
                      width: MediaQuery.of(context).size.width / 3, height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
