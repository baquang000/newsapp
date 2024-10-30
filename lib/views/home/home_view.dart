import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/components/news_tile_loading.dart';
import 'package:newsapp/components/trending_loading_card.dart';
import 'package:newsapp/controllers/new_controller.dart';
import 'package:newsapp/views/home/widgets/news_tile.dart';
import 'package:newsapp/views/home/widgets/trending_card.dart';

import '../news_details/new_details_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController controller = Get.put(NewsController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    controller.getTrendingNews();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(Icons.dashboard),
                      ),
                      const Text(
                        "News App",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(Icons.person),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hottest News",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "See All",
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => controller.isLoading.value
                        ? const Row(
                            children: [
                              TrendingLoadingCard(),
                              TrendingLoadingCard(),
                            ],
                          )
                        : Row(
                            children: controller.trendingNewList
                                .map(
                                  (e) => TrendingCard(
                                    onTap: () {
                                      Get.to(NewDetailsView(news: e));
                                    },
                                    urlImage: e.urlToImage ??
                                        'https://static.mygov.in/indiancc/2023/01/mygov-999999999695087927-1024x705.jpg',
                                    tag: 'Trending no 1',
                                    time: e.publishedAt.toString(),
                                    title: e.title ?? 'Save water Save life',
                                    author: e.author ?? 'Quang',
                                  ),
                                )
                                .toList()),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "News for you",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "See All",
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => controller.isLoading.value
                      ? const Row(
                          children: [
                            NewsTileLoading(),
                            NewsTileLoading(),
                          ],
                        )
                      : Column(
                          children: controller.trendingNewList
                              .map(
                                (e) => NewsTile(
                                  onTap: () {
                                    Get.to(NewDetailsView(news: e));
                                  },
                                  author: e.author ?? 'Quang',
                                  description: e.description ?? "No",
                                  time: e.publishedAt!.toIso8601String(),
                                  urlImage: e.urlToImage ??
                                      'https://nguoiduatin.mediacdn.vn/84137818385850368/2024/10/24/mu-17298091938001262138731.jpg',
                                ),
                              )
                              .toList()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
