import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(0),
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16),
          ),
          child: CloudStorageDemo()
          // child: Column(
          //   children: [
          //     Text('GalleryPage'),
          //     // _buildProfile(context),
          //     // SizedBox(height: ScreenUtil().setHeight(41)),
          //     // _buildAccountInfo(context)
          //   ],
          // ),
          ),
    );
  }
}

class CloudStorageDemo extends StatefulWidget {
  @override
  CloudStorageDemoState createState() {
    return CloudStorageDemoState();
  }
}

class CloudStorageDemoState extends State<CloudStorageDemo> {
  PickedFile _image;
  FirebaseProvider fp;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  ImagePicker _picker = ImagePicker();
  String _profileImageURL = "";
  int _uploadTime = 0;
  int _downloadTime = 0;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Cloud Storage Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 업로드할 이미지를 출력할 CircleAvatar
            CircleAvatar(
              backgroundImage: NetworkImage(""),
              // (_image != null) ? File(_image.path) : NetworkImage(""),
              radius: 30,
            ),
            // 업로드할 이미지를 선택할 이미지 피커 호출 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Gallery"),
                  onPressed: () {
                    _uploadImageToStorage(ImageSource.gallery);
                  },
                ),
                RaisedButton(
                  child: Text("Camera"),
                  onPressed: () {
                    _uploadImageToStorage(ImageSource.camera);
                  },
                )
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            // 업로드 된 이미지를 출력할 CircleAvatar
            // CircleAvatar(
            //   backgroundImage: NetworkImage(""),
            //   radius: 30,
            // ),
            Text(_uploadTime.toString()),
            Text(_downloadTime.toString()),
            // 업로드 된 이미지의 URL
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_profileImageURL),
            )
          ],
        ),
      ),
    );
  }

  void _uploadImageToStorage(ImageSource source) async {
    PickedFile image = await _picker.getVideo(source: source);

    if (image == null) return;
    setState(() {
      _image = image;
    });

    // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
    Reference storageReference =
        _firebaseStorage.ref().child("${fp.getUser().uid}");
    logger.d("upload start");
    DateTime start = DateTime.now();
    // 파일 업로드
    UploadTask storageUploadTask = storageReference.putFile(File(_image.path));

    // 파일 업로드 완료까지 대기
    TaskSnapshot shot = await storageUploadTask.whenComplete(() => null);
    _uploadTime = DateTime.now().difference(start).inSeconds;
    logger.d(_uploadTime);
    // 업로드한 사진의 URL 획득
    String downloadURL = await storageReference.getDownloadURL();

    // 업로드된 사진의 URL을 페이지에 반영
    setState(() {
      _profileImageURL = downloadURL;
    });
  }
}
