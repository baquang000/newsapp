import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controllers/new_controller.dart';
import 'package:newsapp/views/home/widgets/news_tile.dart';
import 'package:newsapp/views/home/widgets/trending_card.dart';

import '../news_details/new_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final scrollControllerTrending = ScrollController();
  final scrollController = ScrollController();
  NewsController controller = Get.put(NewsController());
  var pageTrending = 1;
  var pageForYou = 1;

  @override
  void initState() {
    super.initState();
    scrollControllerTrending.addListener(() {
      if (scrollControllerTrending.position.atEdge &&
          scrollControllerTrending.position.pixels != 0) {
        // Load more data when reaching the end of scroll
        pageTrending++;
        controller.getTrendingNews(pageTrending);
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        // Load more news for you
        pageForYou++;
        controller.getNewsForYou(pageForYou);
      }
    });
  }

  @override
  void dispose() {
    scrollControllerTrending.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Top Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(Icons.person),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    // "Hottest News" Header Row
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              // Trending News Horizontal List
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 350,
                  child: Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: scrollControllerTrending,
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.trendingNewList.length + 1,
                        itemBuilder: (context, index) {
                          if (index < controller.trendingNewList.length) {
                            final e = controller.trendingNewList[index];
                            return TrendingCard(
                              onTap: () {
                                Get.to(NewDetailsView(news: e));
                              },
                              urlImage: e.urlToImage ??
                                  'https://static.mygov.in/indiancc/2023/01/mygov-999999999695087927-1024x705.jpg',
                              tag: 'Trending no 1',
                              time: e.publishedAt.toString(),
                              title: e.title ?? 'Save water Save life',
                              author: e.author ?? 'Quang',
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      )),
                ),
              ),
              // News for You Header Row
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("News for you",
                          style: Theme.of(context).textTheme.bodyLarge),
                      Text("See All",
                          style: Theme.of(context).textTheme.labelSmall)
                    ],
                  ),
                ),
              ),
              // News for You Vertical List
              Obx(() => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index < controller.newsForYou.length) {
                          final e = controller.newsForYou[index];
                          return NewsTile(
                            onTap: () {
                              Get.to(NewDetailsView(news: e));
                            },
                            author: e.author ?? 'Quang',
                            description: e.description ?? "No description",
                            time: e.publishedAt?.toIso8601String() ?? '',
                            urlImage: e.urlToImage ??
                                'https://nguoiduatin.mediacdn.vn/84137818385850368/2024/10/24/mu-17298091938001262138731.jpg',
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 32),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                      childCount: controller.newsForYou.length + 1,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
