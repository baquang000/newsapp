import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/news.dart';

class NewsController extends GetxController {
  static const base_url = "http://192.168.10.158:3000";

  RxList<News> trendingNewList = <News>[].obs;
  RxBool isLoading = false.obs;

  RxList<News> searchNewList = <News>[].obs;
  RxBool isSearch = false.obs;

  @override
  void onInit() async {
    super.onInit();
    getTrendingNews();
  }

  Future<void> getTrendingNews() async {
    isLoading.value = true;
    try {
      var response = await http.get(Uri.parse("$base_url/news/getData"));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var data = body['data'];
        for (var news in data) {
          trendingNewList.add(News.fromJson(news));
        }
      } else {
        print("Get data news failed");
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchNews(String key) async {
    isSearch.value = true;
    searchNewList.clear();
    try {
      var response = await http.get(Uri.parse("$base_url/news/search/$key"));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var data = body['data'];
        var i = 0;
        for (var news in data) {
          i++;
          searchNewList.add(News.fromJson(news));
          if(i == 10) break;
        }
      } else {
        print("Get data news failed");
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isSearch.value = false;
    }
  }
}
