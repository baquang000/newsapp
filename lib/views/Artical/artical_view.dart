import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controllers/new_controller.dart';
import 'package:newsapp/views/Artical/widget/search_widget.dart';
import 'package:newsapp/views/news_details/new_details_view.dart';

import '../home/widgets/news_tile.dart';

class ArticalView extends StatelessWidget {
  const ArticalView({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put(NewsController());
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            const SearchWidget(),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => newsController.isSearch.value
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: newsController.searchNewList
                          .map((e) => NewsTile(
                                author: e.author ?? "Unknown",
                                description: e.description ?? "No description",
                                time: e.publishedAt.toString(),
                                urlImage: e.urlToImage ??
                                    "https://nguoiduatin.mediacdn.vn/84137818385850368/2024/10/24/mu-17298091938001262138731.jpg",
                                onTap: () {
                                  Get.to(NewDetailsView(news: e));
                                },
                              ))
                          .toList(),
                    ),
            )
          ],
        ),
      )),
    );
  }
}
