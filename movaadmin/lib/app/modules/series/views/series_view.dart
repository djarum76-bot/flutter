import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

import '../controllers/series_controller.dart';

class SeriesView extends GetView<SeriesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SeriesView'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(Get.height * 0.01),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.01),
                child: TextFormField(
                  controller: controller.title,
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.02),
                child: TextFormField(
                  controller: controller.description,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Genre",
                      style: TextStyle(fontSize: 18),
                    ),
                    Wrap(
                      children: _buildChipGenre(),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.05,
                      child: ListView(
                        children: _buildChipCategory(),
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Region",
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.05,
                      child: ListView(
                        children: _buildChipRegion(),
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Release",
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.05,
                      child: ListView(
                        children: _buildChipRelease(),
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rating",
                      style: TextStyle(fontSize: 18),
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        controller.rating.value = rating;
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Thumbnail",
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
                      ),
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              child: Obx((){
                                return Text(
                                  controller.thumbnailName.value,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                );
                              }),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: (){
                                controller.ambilThumbnail();
                              },
                              child: Text(
                                  "Upload"
                              )
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Video",
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
                      ),
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              child: Obx((){
                                return Text(
                                  controller.videoName.value,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                );
                              }),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: (){
                                controller.ambilVideo();
                              },
                              child: Text(
                                  "Upload"
                              )
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.01),
                child: ElevatedButton(
                    onPressed: (){
                      // controller.uploadMovie();
                      controller.uploadSeries();
                    },
                    child: Text(
                        "Upload"
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildChipGenre() {
    List<Widget> choices = [];

    controller.genreList.forEach((item) {
      choices.add(
          Obx(() {
            return Container(
              margin: EdgeInsets.only(left: Get.height * 0.007),
              child: ChoiceChip(
                label: Text(item, maxLines: 1,),
                labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: controller.selectedGenre.contains(item) ? Colors.white : Colors.black),
                selected: controller.selectedGenre.contains(item),
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.037913602941176475),
                labelPadding: EdgeInsets.symmetric(vertical: Get.height * 0.002527573529411765),
                selectedColor: Colors.blue,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black),
                onSelected: (selected) {
                  if(selected){
                    controller.selectedGenre.add(item);
                  }else{
                    controller.selectedGenre.remove(item);
                  }
                },
              ),
            );
          })
      );
    });

    return choices;
  }

  _buildChipCategory() {
    List<Widget> choices = [];

    controller.categoryList.forEach((item) {
      choices.add(
          Obx(() {
            return Container(
              margin: EdgeInsets.only(left: Get.height * 0.007),
              child: ChoiceChip(
                label: Text(item, maxLines: 1,),
                labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: controller.selectedCategory.value == item ? Colors.white : Colors.black),
                selected: controller.selectedCategory.value == item,
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.037913602941176475),
                labelPadding: EdgeInsets.symmetric(vertical: Get.height * 0.002527573529411765),
                selectedColor: Colors.blue,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black),
                onSelected: (selected) {
                  controller.selectedCategory.value = item;
                },
              ),
            );
          })
      );
    });

    return choices;
  }

  _buildChipRegion() {
    List<Widget> choices = [];

    controller.regionList.forEach((item) {
      choices.add(
          Obx(() {
            return Container(
              margin: EdgeInsets.only(left: Get.height * 0.007),
              child: ChoiceChip(
                label: Text(item, maxLines: 1,),
                labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: controller.selectedRegion.value == item ? Colors.white : Colors.black),
                selected: controller.selectedRegion.value == item,
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.037913602941176475),
                labelPadding: EdgeInsets.symmetric(vertical: Get.height * 0.002527573529411765),
                selectedColor: Colors.blue,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black),
                onSelected: (selected) {
                  controller.selectedRegion.value = item;
                },
              ),
            );
          })
      );
    });

    return choices;
  }

  _buildChipRelease() {
    List<Widget> choices = [];

    controller.releaseList.forEach((item) {
      choices.add(
          Obx(() {
            return Container(
              margin: EdgeInsets.only(left: Get.height * 0.007),
              child: ChoiceChip(
                label: Text(item, maxLines: 1,),
                labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: controller.selectedRelease.value == item ? Colors.white : Colors.black),
                selected: controller.selectedRelease.value == item,
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.037913602941176475),
                labelPadding: EdgeInsets.symmetric(vertical: Get.height * 0.002527573529411765),
                selectedColor: Colors.blue,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black),
                onSelected: (selected) {
                  controller.selectedRelease.value = item;
                },
              ),
            );
          })
      );
    });

    return choices;
  }
}
