import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mello_d/extensions/int_extension.dart';
import 'package:mello_d/layers/styles/app_styles.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
          child: Column(
            children: [
              1.height(context),
              TextFormField(
                controller: searchController,
                onChanged: (val) {
                  
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius + 20),
                  ),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                  ),
                  suffixIcon: Visibility(
                    visible: searchController.text.isNotEmpty,
                    child: const Icon(
                      CupertinoIcons.clear,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
