import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nonolep/components/custom_app_dialog.dart';
import 'package:nonolep/components/workout_content_item.dart';
import 'package:nonolep/components/workout_level_item.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:nonolep/utils/helpers/dummy_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DiscoverScreen extends StatefulWidget{
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late String _level;
  late TextEditingController _search;
  late FocusNode _searchFocus;

  bool _isSearching = false;
  bool _isSearched = false;

  @override
  void initState() {
    _level = DummyHelper.levels[0];
    _search = TextEditingController();
    _searchFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        if(_isSearching || _isSearched){
          _search.clear();
          setState(() {
            _isSearching = false;
            _isSearched = false;
          });
        }else{
          CustomAppDialog.exitApplication(context);
        }

        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _discoverBody(context),
      ),
    );
  }

  Widget _discoverBody(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Column(
              children: [
                _discoverAppBar(context),
                _discoverLevelList(context)
              ],
            ),
            _discoverMainSection(context)
          ],
        ),
      ),
    );
  }

  Widget _discoverAppBar(BuildContext context){
    if(_isSearching || _isSearched){
      return Padding(
        padding: EdgeInsets.fromLTRB(4.w, 1.25.h, 4.w, 1.25.h),
        child: TextFormField(
          controller: _search,
          focusNode: _searchFocus,
          style: GoogleFonts.urbanist(color: Colors.white),
          decoration: AppTheme.inputSearchDecoration(
            onTap: (){
              _search.clear();
              _searchFocus.requestFocus();

              setState(() {
                _isSearching = true;
                _isSearched = false;
              });
            }
          ),
          onTap: (){
            setState(() {
              _isSearching = true;
              _isSearched = false;
            });
          },
          onFieldSubmitted: (val){
            setState(() {
              _isSearching = false;
              _isSearched = val != "";
            });
          },
        ),
      );
    }else{
      return Padding(
        padding: EdgeInsets.fromLTRB(4.w, 1.25.h, 4.w, 1.25.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 10.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(
                    child: Icon(LineIcons.dumbbell, size: 3.25.vmax, color: Colors.white,),
                  ),
                ),
                SizedBox(width: 3.w,),
                Text(
                  "Discover",
                  style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20.sp),
                )
              ],
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  _isSearching = true;
                });
                _searchFocus.requestFocus();
              },
              child: Icon(LineIcons.search, size: 3.5.vmax, color: Colors.white,),
            ),
          ],
        ),
      );
    }
  }

  Widget _discoverLevelList(BuildContext context){
    return WorkoutLevelItem(
      selectedLevel: _level,
    );
  }

  Widget _discoverMainSection(BuildContext context){
    if(_isSearching){
      return _discoverSearchingSection(context);
    }else if(_isSearched){
      return _discoverSearchedSection(context);
    }else{
      return _discoverInitializeSection(context);
    }
  }

  Widget _discoverSearchingSection(BuildContext context){
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 0.1.h,
              width: double.infinity,
              color: AppTheme.separatorLineColor,
            ),
            SizedBox(height: 2.h),
            Text(
              "Recent",
              style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 17.sp, color: Colors.white),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ListView.builder(
                  itemCount: DummyHelper.history.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 3.h),
                      child: GestureDetector(
                        onTap: (){
                          _search.text = DummyHelper.history[index];
                          _searchFocus.unfocus();

                          setState(() {
                            _isSearching = false;
                            _isSearched = true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                DummyHelper.history[index],
                                style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 16.sp, color: AppTheme.historyColor),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Icon(Icons.highlight_remove_rounded, color: AppTheme.historyColor, size: 3.vmax),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _discoverSearchedSection(BuildContext context){
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemCount: DummyHelper.workouts.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index){
            return WorkoutContentItem(index: index, isHorizontal: false, level: _level,);
          },
        ),
      ),
    );
  }

  Widget _discoverInitializeSection(BuildContext context){
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemCount: DummyHelper.workouts.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index){
            return WorkoutContentItem(index: index, isHorizontal: false, level: _level,);
          },
        ),
      ),
    );
  }
}