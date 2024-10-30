import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  final String author;
  final String description;
  final String time;
  final String urlImage;
  final VoidCallback onTap;


  const NewsTile(
      {super.key,
      required this.author,
      required this.description,
      required this.time,
      required this.urlImage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  urlImage,
                  fit: BoxFit.cover,
                ),
              ),
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
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
