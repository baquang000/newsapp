import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/models/news.dart';

class NewDetailsView extends StatelessWidget {
  final News news;

  const NewDetailsView({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const SizedBox(
                    width: 100,
                    child: Row(
                      children: [Icon(Icons.arrow_back_ios_new), Text("Back")],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 330,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      news.urlToImage ??
                          "https://img.lovepik.com/photo/20211203/medium/lovepik-new-york-city-picture_501490159.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  news.title ?? "No title ",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      news.publishedAt.toString(),
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.red,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      news.author ?? "Unknown",
                      style: TextStyle(
                          fontSize: 18,
                          color:
                              Theme.of(context).colorScheme.secondaryContainer),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Text(
                  news.description ?? 'No description',
                  style: const TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
