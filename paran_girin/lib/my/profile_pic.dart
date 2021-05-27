import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePic createState() => _ProfilePic();
}

class _ProfilePic extends State<ProfilePic> {
  File galleryFile;
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    galleryFile = fp.getStaticInfo().profile;
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
                    : FileImage(File(galleryFile.path))),
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
                        )),
                    color: Colors.white,
                    onPressed: () {
                      takePhoto(ImageSource.gallery);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/camera.svg",
                      color: AppTheme.colors.base1,
                    )),
              ),
            )
          ],
        ));
  }

  void takePhoto(ImageSource source) async {
    final pickedFile =
        await ImagePicker.pickImage(source: source, imageQuality: 5);
    fp.getUploadManager().uploadImage(pickedFile).then((value) {
      fp.getUserInfo().currentChild.profileURL = value;
      fp
          .getFirestore()
          .collection('children')
          .doc(fp.getUserInfo().userInDB.currentChild)
          .set(fp.getUserInfo().currentChild.toJson());
    });
    setState(() {
      fp.getStaticInfo().profile = pickedFile;
    });
  }
}
