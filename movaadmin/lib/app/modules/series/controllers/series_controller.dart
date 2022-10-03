import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movaadmin/app/routes/app_pages.dart';
import 'package:movaadmin/app/utils/utils.dart';

class SeriesController extends GetxController {
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

  final videoFiles = <File>[].obs;
  final videoPaths = <String>[].obs;
  final videoNames = <String>[].obs;
  final videoName = "No File Found".obs;
  ambilVideo()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      videoFiles.value = result.paths.map((path) => File(path!)).toList();
      videoPaths.value = result.paths.map((path) => path!).toList();
      videoNames.value = result.paths.map((path) => path!.split('/').last).toList();
      videoName.value = videoNames.value.join(", ");
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

  Future<void> uploadSeries()async{
    Dio.FormData formData = Dio.FormData.fromMap({
      "thumbnail" : await Dio.MultipartFile.fromFile(thumbnailPath.value, filename: thumbnailName.value),
      "title" : title.text,
      "rating" : rating.value.toString(),
      "category" : selectedCategory.value,
      "description" : description.text,
      "release" : selectedRelease.value,
      "region" : selectedRegion.value,
      "createdAt" : DateTime.now().toIso8601String()
    });

    for (var genre in selectedGenre.value){
      formData.fields.addAll([
        MapEntry("genre", genre)
      ]);
    }

    for (var file in videoPaths.value){
      String filename = file.split('/').last;
      formData.files.addAll([
        MapEntry("episode", await Dio.MultipartFile.fromFile(file, filename: filename))
      ]);
    }

    final response = await dio.post("/series",
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
