import 'package:flutter/material.dart';

class TrendingCard extends StatelessWidget {
  final String urlImage;
  final String tag;
  final String time;
  final String title;
  final String author;
  final VoidCallback onTap;

  const TrendingCard(
      {super.key,
      required this.urlImage,
      required this.tag,
      required this.time,
      required this.title,
      required this.author,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 350,
            width: 280,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primaryContainer),
            child: Column(children: [
              Container(
                height: 200,
                width: 280,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.surface),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    urlImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tag,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
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
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text(
                    author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ))
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
