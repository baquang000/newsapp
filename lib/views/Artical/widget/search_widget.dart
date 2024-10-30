import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controllers/new_controller.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put(NewsController());
    TextEditingController searchController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search news ...",
              suffixIcon: InkWell(
                  onTap: () {
                    newsController.searchNews(searchController.text);
                  },
                  child: const Icon(Icons.search)),
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
          ))
        ],
      ),
    );
  }
}
