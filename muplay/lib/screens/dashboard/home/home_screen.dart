import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:muplay/utils/app_theme.dart';
import 'package:muplay/utils/routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homeBody(context),
    );
  }

  Widget _homeBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
        child: Column(
          children: [
            _homeTitleSearch(context),
            _homeTabBar(),
            _homeTabBarView(context)
          ],
        ),
      ),
    );
  }

  Widget _homeTitleSearch(BuildContext context){
    return SizedBox(
      width: double.infinity,
      height: 5.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFff8e2c),
                radius: 2.h,
                child: Icon(LineIcons.itunesNote, color: Colors.white, size: 3.h,),
              ),
              SizedBox(width: 2.w,),
              Text(
                'MuPlay',
                style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 20.sp),
              )
            ],
          ),
          const Icon(LineIcons.search)
        ],
      ),
    );
  }

  Widget _homeTab({required String label}){
    return Tab(text: label,);
  }

  Widget _homeTabBar(){
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      physics: const BouncingScrollPhysics(),
      indicatorColor: AppTheme.primaryColor,
      indicatorWeight: 4,
      unselectedLabelColor: AppTheme.greyColor,
      unselectedLabelStyle: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 18.sp),
      labelColor: AppTheme.primaryColor,
      labelStyle: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 18.sp),
      tabs: [
        _homeTab(label: 'Suggested'),
        _homeTab(label: 'Songs'),
        _homeTab(label: 'Artists'),
        _homeTab(label: 'Albums'),
      ],
    );
  }

  Widget _homeTabBarView(BuildContext context){
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        physics: const BouncingScrollPhysics(),
        children: [
          _homeSuggestedTab(context),
          _homeSongsTab(context),
          _homeArtistsTab(context),
          _homeAlbumsTab(context),
        ],
      ),
    );
  }

  Widget _homeSuggestedTab(BuildContext context){
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 1.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _homeSuggestedTabItem(
                title: 'Recently Played',
                seeAll: (){},
                item: () => Navigator.pushNamed(context, Routes.musicScreen),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)
                ),
                name: 'Stay This Way - Fromis_9'
            ),
            SizedBox(height: 2.h,),
            _homeSuggestedTabItem(
                title: 'Artists',
                seeAll: (){},
                item: (){},
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle
                ),
                name: 'Fromis_9',
                artists: true
            ),
            SizedBox(height: 2.h,),
            _homeSuggestedTabItem(
                title: 'Most Played',
                seeAll: (){},
                item: () => Navigator.pushNamed(context, Routes.musicScreen),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)
                ),
                name: 'Stay This Way - Fromis_9'
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeSuggestedTabItem({required String title, required void Function()? seeAll, required void Function()? item, required Decoration decoration, required String name, bool artists = false}){
    return SizedBox(
      width: double.infinity,
      height: artists ? 22.h : 25.h,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 5.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 18.sp),
                ),
                GestureDetector(
                  onTap: seeAll,
                  child: Text(
                    'See All',
                    style: GoogleFonts.urbanist(color: AppTheme.primaryColor, fontWeight: FontWeight.w700, fontSize: 16.sp),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: item,
                  child: Container(
                    width: 30.w,
                    margin: EdgeInsets.only(left: index == 0 ? 0 : artists ? 0 : 2.5.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 14.h,
                          decoration: decoration,
                        ),
                        Text(
                          name,
                          style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 17.sp),
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _homeSongsTab(BuildContext context){
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 1.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '14 songs',
              style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 18.sp),
            ),
            const Divider(),
            Wrap(
              children: _homeSongsItemList(context),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _homeSongsItemList(BuildContext context){
    List<Widget> list = <Widget>[];

    for(int i = 0; i < 50; i++){
      list.add(
        _homeSongsItem(
            context: context,
            songTap: () => Navigator.pushNamed(context, Routes.musicScreen)
        )
      );
    }

    return list;
  }

  Widget _homeSongsItem({required BuildContext context, required void Function()? songTap}){
    return GestureDetector(
      onTap: songTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.all(1.h),
        height: 11.h,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
            SizedBox(width: 2.w,),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stay This Way',
                    style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 18.sp),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h,),
                  Text(
                    'Fromis_9 | 03.32 mins',
                    style: GoogleFonts.urbanist(color: AppTheme.greyColor, fontSize: 15.sp),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            SizedBox(width: 2.w,),
            Expanded(
              flex: 1,
              child: Center(
                child: _homeSongsStatus(isPlay: false),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _homeSongsStatus({required bool isPlay}){
    return GestureDetector(
      onTap: (){},
      child: CircleAvatar(
        backgroundColor: isPlay ? const Color(0xFFff8e2c) : AppTheme.scaffoldColor,
        radius: 2.h,
        child: Icon(isPlay ? LineIcons.play : Ionicons.pause, color: isPlay ? Colors.white : AppTheme.primaryColor, size: 3.h,),
      ),
    );
  }

  Widget _homeArtistsTab(BuildContext context){
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 1.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '50 artists',
              style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 18.sp),
            ),
            const Divider(),
            Wrap(
              children: _homeArtistsItemList(context),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _homeArtistsItemList(BuildContext context){
    List<Widget> list = <Widget>[];

    for(int i = 0; i < 50; i++){
      list.add(_homeArtistsItem(context: context, onTap: (){}));
    }

    return list;
  }

  Widget _homeArtistsItem({required BuildContext context, required void Function()? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.all(1.h),
        height: 11.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle
                ),
              ),
            ),
            SizedBox(width: 2.w,),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fromis_9',
                    style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 18.sp),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h,),
                  Text(
                    '1 Album | 16 Songs',
                    style: GoogleFonts.urbanist(color: AppTheme.greyColor, fontSize: 15.sp),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeAlbumsTab(BuildContext context){
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 1.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '50 albums',
              style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 18.sp),
            ),
            const Divider(),
            Wrap(
              children: _homeAlbumsItemList(context),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _homeAlbumsItemList(BuildContext context){
    List<Widget> list = <Widget>[];

    for(int i = 0; i < 50; i++){
      list.add(
        _homeAlbumsItem(context: context, onTap: (){})
      );
    }

    return list;
  }

  Widget _homeAlbumsItem({required BuildContext context, required void Function()? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46.w,
        height: 33.h,
        padding: EdgeInsets.all(1.h),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            SizedBox(
              width: 46.w,
              height: 8.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From Our Memento Box',
                    style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 18.sp),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Fromis_9 | 2022',
                    style: GoogleFonts.urbanist(color: AppTheme.greyColor, fontSize: 15.sp),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '10 songs',
                    style: GoogleFonts.urbanist(color: AppTheme.greyColor, fontSize: 15.sp),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}