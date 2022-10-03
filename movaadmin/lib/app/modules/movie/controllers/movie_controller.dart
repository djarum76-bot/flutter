import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movaadmin/app/routes/app_pages.dart';
import 'package:movaadmin/app/utils/utils.dart';

class MovieController extends GetxController {
  final thumbnailFile = File("").obs;
  final thumbnailPath = "".obs;
  final thumbnailName = "No File Found".obs;
  ambilThumbnail()async{
    XFile? thumbnail = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(thumbnail != null){
      thumbnailFile.value = File(thumbnail.path);
      thumbnailPath.value = thumbnail.path;
      thumbnailName.value = thumbnail.path.split('/').last;
    }
  }

  final videoFile = File("").obs;
  final videoPath = "".obs;
  final videoName = "No File Found".obs;
  ambilVideo()async{
    XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if(video != null){
      videoFile.value = File(video.path);
      videoPath.value = video.path;
      videoName.value = video.path.split('/').last;
    }
  }

  List<String> genreList = [
    "Action",
    "Drama",
    "Comedy",
    "Horror",
    "Adventure",
    "Thriller",
    "Romance",
    "Science",
    "Music",
    "Documentary",
    "Crime",
    "Fantasy",
    "Mistery",
    "Fiction",
    "War",
    "History",
    "Superheroes",
    "Sport",
  ];
  final selectedGenre = <String>[].obs;

  List<String> categoryList = [
    "Movie",
    "TV Shows",
    "K-Drama",
    "Anime",
  ];
  final selectedCategory = "".obs;

  List<String> regionList = [
    "US",
    "South Korea",
    "Japan",
    "Chinese",
    "Indonesia",
  ];
  final selectedRegion = "".obs;

  List<String> releaseList = [
    "2022",
    "2021",
    "2020",
    "2019",
    "2018",
    "2017",
  ];
  final selectedRelease = "".obs;

  late TextEditingController title;
  late TextEditingController description;

  final rating = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    title = TextEditingController();
    description = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    description.dispose();
  }

  Future<void> uploadMovie()async{
    Dio.FormData formData = Dio.FormData.fromMap({
      "thumbnail" : await Dio.MultipartFile.fromFile(thumbnailPath.value, filename: thumbnailName.value),
      "title" : title.text,
      "rating" : rating.value.toString(),
      "category" : selectedCategory.value,
      "description" : description.text,
      "video" : await Dio.MultipartFile.fromFile(videoPath.value, filename: videoName.value),
      "release" : selectedRelease.value,
      "region" : selectedRegion.value,
      "createdAt" : DateTime.now().toIso8601String()
    });

    for (var genre in selectedGenre.value){
      formData.fields.addAll([
        MapEntry("genre", genre)
      ]);
    }

    final response = await dio.post("/movie",
      data: formData,
      options: Dio.Options(
        headers:{
          "Accept" : "application/json"
        }
      )
    );

    if(response.statusCode == 200){
      Get.offAllNamed(Routes.HOME);
    }else{
      print("Gagal");
    }
  }
}
