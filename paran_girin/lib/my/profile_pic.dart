import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File galleryFile;
    bool image_change = false;
    return SizedBox(
      width: ScreenUtil().setWidth(120),
      height: ScreenUtil().setHeight(120),
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: galleryFile == null
                ? AssetImage("assets/images/default_profile.png")
                : Image.file(galleryFile)),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              width: ScreenUtil().setWidth(28),
              height: ScreenUtil().setHeight(28),
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color: AppTheme.colors.base1,
                  )
                ),
                color: Colors.white,
                onPressed: () async {
                  galleryFile = await ImagePicker.pickImage(
                    source: ImageSource.gallery,
                    // maxHeight: 50.0,
                    // maxWidth: 50.0,
                  );
                  // setState(() {});
                },
                child: SvgPicture.asset(
                  "assets/icons/camera.svg",
                  color: AppTheme.colors.base1,)
              ),
            ),
          )
        ],
      )
    );
  }
}