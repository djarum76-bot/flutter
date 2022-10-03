import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persist/app/models/screen_model.dart';
import 'package:persist/app/modules/home/controllers/home_controller.dart';

class PageColorList extends StatelessWidget {
  final ScreenModel model;
  const PageColorList({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(model.name), backgroundColor: model.colors),
      body: ListView.builder(
        itemBuilder: (_, idx) {
          final shade = model.shades[idx];
          return Container(
            color: model.colors[shade],
            child: ListTile(
              title: Text(
                'shade [$shade]',
                style: Get.textTheme.bodyText2!.copyWith(
                    color: Colors.white, backgroundColor: Colors.black26),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Get.find<HomeController>().openDetails(shade),
            ),
          );
        },
        itemCount: model.shades.length,
      ),
    );
  }
}