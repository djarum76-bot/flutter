import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:muplay/commons/app_button.dart';
import 'package:muplay/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PlaylistsScreen extends StatefulWidget{
  const PlaylistsScreen({super.key});

  @override
  State<PlaylistsScreen> createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _playlistsBody(context),
    );
  }

  Widget _playlistsBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
        child: Column(
          children: [
            _playlistsTitle(),
            _playlistsData(context)
          ],
        ),
      ),
    );
  }

  Widget _playlistsTitle(){
    return SizedBox(
      width: double.infinity,
      height: 5.h,
      child: Text(
        'Playlists',
        style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 20.sp),
      ),
    );
  }

  Widget _playlistsData(BuildContext context){
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 1.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '14 playlists',
                style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 18.sp),
              ),
              const Divider(),
              Wrap(
                children: _playlistsItemList(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _playlistsItemList(BuildContext context){
    List<Widget> list = <Widget>[];

    for(int i = -1; i < 50; i++){
      if(i == -1){
        list.add(_addPlaylistsItem(context: context));
      }else{
        list.add(_playlistsItem(context: context, onTap: (){}));
      }
    }

    return list;
  }

  Widget _addPlaylistsItem({required BuildContext context}){
    return GestureDetector(
      onTap: (){
        _addPlaylistsBottomSheet(context: context);
      },
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
                decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle
                ),
                child: Center(
                  child: Icon(LineIcons.plus, color: Colors.white, size: 4.h,),
                ),
              ),
            ),
            SizedBox(width: 2.w,),
            Expanded(
              flex: 8,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Add New Playlist',
                  style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 18.sp),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _addPlaylistsBottomSheet({required BuildContext context})async{
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )
      ),
      builder: (context){
        return _addPlaylistsBottomSheetItem(context: context);
      }
    );
  }

  Widget _addPlaylistsBottomSheetItem({required BuildContext context}){
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.scaffoldColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )
      ),
      padding: EdgeInsets.all(2.h),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 10.w,
                  height: 0.75.h,
                  decoration: BoxDecoration(
                      color: const Color(0xFFe0e0e1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 3.h,),
                Text(
                  'New Playlist',
                  style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 20.sp),
                ),
                SizedBox(height: 2.h,),
                const Divider(),
                SizedBox(height: 2.h,),
                TextFormField(
                  controller: _name,
                  decoration: AppTheme.inputDecoration(),
                  keyboardType: TextInputType.name,
                  validator: ValidationBuilder().build(),
                ),
                SizedBox(height: 2.h,),
                const Divider(),
                SizedBox(height: 2.h,),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        text: 'Cancel',
                        textColor: AppTheme.primaryColor,
                        backgroundColor: const Color(0xFFfff3e8),
                      ),
                    ),
                    SizedBox(width: 2.h,),
                    Expanded(
                      child: AppButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            Navigator.pop(context);
                          }
                        },
                        text: 'Create',
                        textColor: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _playlistsItem({required BuildContext context, required void Function()? onTap}){
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
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '90s Old Song',
                    style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 18.sp),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h,),
                  Text(
                    '12 songs',
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