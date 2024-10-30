import 'package:flutter/material.dart';

import 'loading_container.dart';

class TrendingLoadingCard extends StatelessWidget {
  const TrendingLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(5),
            width: 280,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primaryContainer),
            child: Column(children: [
              const LoadingContainer(
                height: 200,
                width: 280,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoadingContainer(
                      width: MediaQuery.of(context).size.width / 3, height: 10),
                  LoadingContainer(
                      width: MediaQuery.of(context).size.width / 3, height: 10),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoadingContainer(
                      width: MediaQuery.of(context).size.width / 2, height: 20),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const LoadingContainer(width: 30, height: 30),
                  const SizedBox(
                    width: 10,
                  ),
                  LoadingContainer(
                      width: MediaQuery.of(context).size.width / 3, height: 20),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
