import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:resep/ad_helper.dart';
import 'package:resep/app/models/recipe_models.dart';

import '../../../controllers/service_controller.dart';

class DetailController extends GetxController {
  final serviceC = Get.find<ServiceController>();

  getRecipe()async{
    final response = await dio.get('/api/recipe/${Get.arguments[0]}',
        options: Options(
            headers: {
              "Accept": "application/json"
            }
        )
    );

    final data = response.data;

    if(response.statusCode == 200){
      serviceC.recipe(RecipeModel.fromJson(data));
      serviceC.recipe.refresh();
    }
  }

  // TODO: Add _bannerAd
  late BannerAd bannerAd;

  // TODO: Add _isBannerAdReady
  final isBannerAdReady = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isBannerAdReady.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          isBannerAdReady.value = false;
          ad.dispose();
        },
      ),
    );

    bannerAd.load();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bannerAd.dispose();
  }
}
