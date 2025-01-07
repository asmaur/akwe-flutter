import 'package:akwe/src/ui/widgets/app_drawer/app_drawer_mobile.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:get/get.dart';

class SearchPageView extends StatelessWidget {
  SearchPageView({super.key});

  final SearchController _searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation.appSearchPageTitle.tr,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),
        ),
      ),
      drawer: AppDrawerMobile(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SearchAnchor(
                searchController: _searchController,
                isFullScreen: false,
                viewConstraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    leading: IconButton(
                      icon: const Icon(Icons.search_outlined),
                      onPressed: () {
                      },
                    ),
                    trailing: [
                      IconButton(
                        icon: const Icon(Icons.keyboard_voice),
                        onPressed: () {
                        },
                      ),
                    ],
                    onTap: () {
                      _searchController.openView();
                    },
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  final keyword = controller.value.text;
                  return List.generate(5, (index) => 'Item $index')
                      .where((element) => element
                      .toLowerCase()
                      .startsWith(keyword.toLowerCase()))
                      .map((item) => ListTile(
                    title: Text(item),
                    onTap: () {
                      // setState(() {
                      //   controller.closeView(item);
                      //   FocusScope.of(context).unfocus();
                      // });
                    },
                  ));
                },
              ),
              Expanded(
                child: Center(
                    child: Text(
                        translation.appSearchPageEmptyKeyword.tr
                    ),
                  // _searchController.text.isEmpty
                  //     ? const Text('No keyword')
                  //     : Text('Keyword: ${_searchController.value.text}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

