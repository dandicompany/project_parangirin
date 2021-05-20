import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import "package:http/http.dart" as http;
import "package:googleapis_auth/auth_io.dart";
import 'package:video_compress/video_compress.dart';
import "package:googleapis_auth/auth_io.dart" as gauth;

const String title = "FileUpload Sample app";
const String uploadURL =
    "https://storage.googleapis.com/upload/storage/v1/b/tonal-baton-245112.appspot.com/o?";

const String uploadBinaryURL =
    "https://storage.googleapis.com/upload/storage/v1/b/tonal-baton-245112.appspot.com/o?";
enum MediaType { Image, Video }

class UploadItem {
  final String id;
  final String tag;
  final MediaType type;
  final int progress;
  final UploadTaskStatus status;

  UploadItem({
    this.id,
    this.tag,
    this.type,
    this.progress = 0,
    this.status = UploadTaskStatus.undefined,
  });

  UploadItem copyWith({UploadTaskStatus status, int progress}) => UploadItem(
      id: this.id,
      tag: this.tag,
      type: this.type,
      status: status ?? this.status,
      progress: progress ?? this.progress);

  bool isCompleted() =>
      this.status == UploadTaskStatus.canceled ||
      this.status == UploadTaskStatus.complete ||
      this.status == UploadTaskStatus.failed;
}

class UploadManager {
  String uploadURL =
      "https://storage.googleapis.com/upload/storage/v1/b/tonal-baton-245112.appspot.com/o?";
  FlutterUploader uploader = FlutterUploader();
  StreamSubscription _progressSubscription;
  StreamSubscription _resultSubscription;
  Subscription _subscription;
  Map<String, UploadItem> _tasks = {};
  UploadManager() {
    _progressSubscription = uploader.progress.listen((progress) {
      final task = _tasks[progress.tag];
      print("progress: ${progress.progress} , tag: ${progress.tag}");
      if (task == null) return;
      if (task.isCompleted()) return;
    });
    _resultSubscription = uploader.result.listen((result) {
      print(
          "id: ${result.taskId}, status: ${result.status}, response: ${result.response}, statusCode: ${result.statusCode}, tag: ${result.tag}, headers: ${result.headers}");

      final task = _tasks[result.tag];
      if (task == null) return;
    });
  }

  Future<String> getServiceAccountToken() async {
    gauth.ServiceAccountCredentials accountCredentials =
        gauth.ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "tonal-baton-245112",
      "private_key_id": "8da87a101e5274ce9d75e77975706147dd2a5e5b",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCHdHtbg35h8kcf\n4C7LLu/Cvvn5z9j7KWv1xa8+sPIoFhIeoIl5NY0k9dlun0vlocPLtQ1s5njNFWrw\nFc+vrXhaLIa4QKrfgPxtJBL9K/UC5F+gbfEzi2iRBqKgrP4W8UA3gCIzQ9oMXmru\nFOXsHAQvw7o9/u4MxyJmR+z/tzbJtrbuMc2J4+IWs6CSzB5hMGA/NLLSGUNau83a\nYWLdX/uO4gNrrBML/8+G4mSnGJe1vNQbsBQZKeipKNPIfL+pPpcXal7QVcNe6yqv\nS2diGJkWEHqQC3VCRhRH7Yc6b3ZvuxwsHQKdF/krrI8VGP9iVb4dDDGrQ1PTroZb\nz4GmuLL3AgMBAAECggEAMYft/bo5Eh7SVD0ZT1Hz+V31MZyHxtvQLvhhCwcQHYlo\nicuBSZHD8XJ21iUozyjWXFxxstMZ9EAzMOSA48gGfM7QWnrHIOBdLZml2e7jcnHI\n5/Sb4RHGpFVtTVzEsuX36fOQTfevOZui9TkuFCbwfvjO1xGrwX9lvEnrx1wbDCoc\nP3rjF3idtoTI/tD71ZzNSGdHEg8Kxu4XMvlOkagzq/IWiGDuS+f59MpFOIO+UPea\n1hr7+2y6PUTc4KENLXf4oMowjP0IspqfN8rwkh3eaa8sv3v9nWy4xQiohfnCPm2u\nNFYzddSNlCngATnljLYV/ViZ8BipHSJZj+Do1p28VQKBgQC/i26h2ebGgQPxswy9\nBxRd+or3lHH6lO5TPz/Mr+gfSnR/x13v1a7Q+PRTfdwn9PASluK2xXuajm/inCns\n1qAgnV8Uufk7VGiPcXF3iBnNJRSY1ZIQhqmgcbhtiFCxMXF7CNvewwb6TJvfgnLG\nRzm48Hsk+WDXF23y22csK5+LpQKBgQC1CThyhkAFUM+iW8FWwmEoV/tK1hiuL91t\nLWwUkq0lel8ZNRiFNwIBGswXYW0eTAvwgjlsEHbs6PUCDo6+WX0ov5FKv203JuU6\nlmmiMzikUykCtBgeLRJFzwC7+3677Rtk8RtLUr2hbfLzCs/l1F5jY4r+tD04zWn9\ncUltXdfxawKBgQCk1kpD8PCf3YFWbB7HQaNuaOFUxKP94FLkwyaVcMBSxVFScXDO\np9aEseoZO9PNcwVzCfRbE8IWNQPmQTv3PJCa4LNlc9IfE7nTz+20zyRdHc8G46yK\nmki58YOkh03h30nodqw4nR+RIYJ2q504My1ikVl4bT/AesI84EF+iqAHnQKBgQCI\n5MkHaNb+bgYkOofvaBr529XM2CpfhRhGF4PT5roBThCdShYZnefpF+9eerB9qXmZ\ny49KVQTozpt+i62K6LaI2psuT6RxgPrzm4uTOHJLaArp3W8jWmen3AktHNbPmlMN\nuHgwNAfrCu4ctH9Sxoz9UOdpBLgKvOG54TFp/v1sswKBgHd6mZLLJLzGwp/Zbf/s\nXcq60dtEgeX76F8MBz+/xfwjkDyfH7+BOaI6pCWqtlXZlLxI3F/vqgxmcnfmLezI\nJ12bqHpSzq6QoP044jiLBVXHbVkV5dnRWYfSCnMeDNoPuKiviREdhfkjrFzT4RGz\nQLJkbYX+ra7f3Wj5jbVA7uKt\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-k4hea@tonal-baton-245112.iam.gserviceaccount.com",
      "client_id": "110538781544481540436",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-k4hea%40tonal-baton-245112.iam.gserviceaccount.com"
    });
    List<String> scopes = [
      'https://www.googleapis.com/auth/cloud-platform',
    ];
    var client = new http.Client();
    gauth.AccessCredentials credentials =
        await gauth.obtainAccessCredentialsViaServiceAccount(
            accountCredentials, scopes, client);
    String accessToken = credentials.accessToken.data;
    return accessToken;
  }

  String _uploadUrl({bool binary, String name, String token = ""}) {
    if (binary) {
      return uploadBinaryURL + "name=${name}";
    } else {
      return uploadURL + "name=${name}";
    }
  }

  Future<String> uploadImage(String path) async {
    // var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    logger.d(path);
    File file = File(path);
    logger.d(file.path);

    // MediaInfo mediaInfo = await VideoCompress.compressVideo(
    //   video.path,
    //   quality: VideoQuality.MediumQuality,
    //   deleteOrigin: false, // It's false by default
    // );
    // File thumbnail = await VideoCompress.getFileThumbnail(video.path);

    logger.d(file.length());
    final String savedDir = dirname(file.path);
    final String filename = basename(file.path);
    final tag = "video upload ${_tasks.length + 1} size: ${file.path}";
    final url = _uploadUrl(binary: false, name: filename);

    var fileItem = FileItem(
      filename: filename,
      savedDir: savedDir,
      fieldname: "file",
    );

    var taskId = await uploader.enqueue(
      url: url,
      headers: {
        "Authorization": "Bearer ${await getServiceAccountToken()}",
        "Content-Type": "video/mp4"
      },
      files: [fileItem],
      method: UploadMethod.POST,
      tag: tag,
      showNotification: true,
    );
    return filename;
  }

  Future<String> uploadVideo(String path) async {
    // var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    logger.d(path);
    File file = File(path);
    logger.d(file.path);
    MediaInfo mediaInfo = await VideoCompress.compressVideo(
      path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false, // It's false by default
    );
    // File thumbnail = await VideoCompress.getFileThumbnail(video.path);

    logger.d(mediaInfo.filesize);
    final String savedDir = dirname(mediaInfo.path);
    final String filename = basename(mediaInfo.path);
    final tag = "video upload ${_tasks.length + 1} size: ${mediaInfo.filesize}";
    final url = _uploadUrl(binary: false, name: filename);

    var fileItem = FileItem(
      filename: filename,
      savedDir: savedDir,
      fieldname: "file",
    );

    var taskId = await uploader.enqueue(
      url: url,
      headers: {
        "Authorization": "Bearer ${await getServiceAccountToken()}",
        "Content-Type": "video/mp4"
      },
      files: [fileItem],
      method: UploadMethod.POST,
      tag: tag,
      showNotification: true,
    );
    return filename;
  }
}

// class App extends StatefulWidget {
//   final Widget child;

//   App({Key key, this.child}) : super(key: key);

//   _AppState createState() => _AppState();
// }

// class _AppState extends State<App> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: title,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: UploadScreen(),
//     );
//   }
// }

// class UploadItem {
//   final String id;
//   final String tag;
//   final MediaType type;
//   final int progress;
//   final UploadTaskStatus status;

//   UploadItem({
//     this.id,
//     this.tag,
//     this.type,
//     this.progress = 0,
//     this.status = UploadTaskStatus.undefined,
//   });

//   UploadItem copyWith({UploadTaskStatus status, int progress}) => UploadItem(
//       id: this.id,
//       tag: this.tag,
//       type: this.type,
//       status: status ?? this.status,
//       progress: progress ?? this.progress);

//   bool isCompleted() =>
//       this.status == UploadTaskStatus.canceled ||
//       this.status == UploadTaskStatus.complete ||
//       this.status == UploadTaskStatus.failed;
// }

// enum MediaType { Image, Video }

// class UploadScreen extends StatefulWidget {
//   UploadScreen({Key key}) : super(key: key);

//   @override
//   _UploadScreenState createState() => _UploadScreenState();
// }

// class _UploadScreenState extends State<UploadScreen> {
//   FlutterUploader uploader = FlutterUploader();
//   StreamSubscription _progressSubscription;
//   StreamSubscription _resultSubscription;
//   Subscription _subscription;
//   Map<String, UploadItem> _tasks = {};
//   FirebaseProvider fp;
//   bool _isLoading;
//   @override
//   void initState() {
//     super.initState();
//     // WidgetsFlutterBinding.ensureInitialized();
//     // _subscription = VideoCompress.compressProgress$.subscribe((progress) {
//     //   debugPrint('progress: $progress');
//     // });
//     _progressSubscription = uploader.progress.listen((progress) {
//       final task = _tasks[progress.tag];
//       print("progress: ${progress.progress} , tag: ${progress.tag}");
//       if (task == null) return;
//       if (task.isCompleted()) return;
//       setState(() {
//         _tasks[progress.tag] =
//             task.copyWith(progress: progress.progress, status: progress.status);
//       });
//     });
//     _resultSubscription = uploader.result.listen((result) {
//       print(
//           "id: ${result.taskId}, status: ${result.status}, response: ${result.response}, statusCode: ${result.statusCode}, tag: ${result.tag}, headers: ${result.headers}");

//       final task = _tasks[result.tag];
//       if (task == null) return;

//       setState(() {
//         _tasks[result.tag] = task.copyWith(status: result.status);
//       });
//     }, onError: (ex, stacktrace) {
//       print("exception: $ex");
//       print("stacktrace: $stacktrace" ?? "no stacktrace");
//       final exp = ex as UploadException;
//       final task = _tasks[exp.tag];
//       if (task == null) return;
//       setState(() {
//         _tasks[exp.tag] = task.copyWith(status: exp.status);
//       });
//     });
//     setState(() {
//       _isLoading = true;
//     });
//     _prepare();
//   }

//   @override
//   void dispose() {
//     _progressSubscription?.cancel();
//     _resultSubscription?.cancel();
//     _isLoading = true;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     fp = Provider.of<FirebaseProvider>(context);
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Builder(
//           builder: (context) => _isLoading
//               ? Center(child: CircularProgressIndicator())
//               : Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Container(height: 20.0),
//                       Text(
//                         'multipart/form-data uploads',
//                         style: Theme.of(context).textTheme.subhead,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           RaisedButton(
//                             onPressed: () => getImage(binary: false),
//                             child: Text("upload image"),
//                           ),
//                           Container(width: 20.0),
//                           RaisedButton(
//                             onPressed: () => getVideo(binary: false),
//                             child: Text("upload video"),
//                           )
//                         ],
//                       ),
//                       Container(height: 20.0),
//                       Text(
//                         'binary uploads',
//                         style: Theme.of(context).textTheme.subhead,
//                       ),
//                       Text('this will upload selected files as binary'),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           RaisedButton(
//                             onPressed: () => getImage(binary: true),
//                             child: Text("upload image"),
//                           ),
//                           Container(width: 20.0),
//                           RaisedButton(
//                             onPressed: () => getVideo(binary: true),
//                             child: Text("upload video"),
//                           )
//                         ],
//                       ),
//                       Expanded(
//                         child: ListView.separated(
//                           padding: EdgeInsets.all(20.0),
//                           itemCount: _tasks.length,
//                           itemBuilder: (context, index) {
//                             final item = _tasks.values.elementAt(index);
//                             print("${item.tag} - ${item.status}");
//                             return UploadItemView(
//                               item: item,
//                               onCancel: cancelUpload,
//                             );
//                           },
//                           separatorBuilder: (context, index) {
//                             return Divider(
//                               color: Colors.black,
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ));
//   }

//   String _uploadUrl({bool binary, String name, String token = ""}) {
//     if (binary) {
//       return uploadBinaryURL + "name=${name}";
//     } else {
//       return uploadURL + "name=${name}&token=${token}";
//     }
//   }

//   Future getImage({@required bool binary}) async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       final String filename = basename(image.path);
//       final String savedDir = dirname(image.path);
//       final tag = "image upload ${_tasks.length + 1}";
//       var url = _uploadUrl(binary: binary, name: filename);
//       var fileItem = FileItem(
//         filename: filename,
//         savedDir: savedDir,
//         fieldname: "file",
//       );
//       logger.d("Bearer ${await fp.getServiceAccountToken()}");
//       var taskId = binary
//           ? await uploader.enqueueBinary(
//               url: url,
//               file: fileItem,
//               method: UploadMethod.POST,
//               headers: {
//                 "Authorization": "Bearer ${await fp.getServiceAccountToken()}",
//                 "Content-Type": "image/jpeg"
//               },
//               tag: tag,
//               showNotification: true,
//             )
//           : await uploader.enqueue(
//               url: url,
//               headers: {
//                 "Authorization": "Bearer ${await fp.getServiceAccountToken()}",
//                 "Content-Type": "image/jpeg"
//               },
//               files: [fileItem],
//               method: UploadMethod.POST,
//               tag: tag,
//               showNotification: true,
//             );

//       setState(() {
//         _tasks.putIfAbsent(
//             tag,
//             () => UploadItem(
//                   id: taskId,
//                   tag: tag,
//                   type: MediaType.Video,
//                   status: UploadTaskStatus.enqueued,
//                 ));
//       });
//     }
//   }

//   Future getVideo({@required bool binary}) async {
//     var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
//     if (video != null) {
//       logger.d(await video.length());
//       MediaInfo mediaInfo = await VideoCompress.compressVideo(
//         video.path,
//         startTime: 0,
//         duration: 90,
//         quality: VideoQuality.MediumQuality,
//         deleteOrigin: false, // It's false by default
//       );
//       logger.d(mediaInfo.filesize);
//       final String savedDir = dirname(mediaInfo.path);
//       final String filename = basename(mediaInfo.path);
//       final tag =
//           "video upload ${_tasks.length + 1} size: ${await video.length()}";
//       final url = _uploadUrl(
//           binary: binary,
//           name: filename,
//           token: await fp.getUser().getIdToken());

//       var fileItem = FileItem(
//         filename: filename,
//         savedDir: savedDir,
//         fieldname: "file",
//       );

//       var taskId = binary
//           ? await uploader.enqueueBinary(
//               url: url,
//               file: fileItem,
//               headers: {
//                 "Authorization": "Bearer ${await fp.getServiceAccountToken()}",
//               },
//               method: UploadMethod.POST,
//               tag: tag,
//               showNotification: true,
//             )
//           : await uploader.enqueue(
//               url: url,
//               headers: {
//                 "Authorization": "Bearer ${await fp.getServiceAccountToken()}",
//                 "Content-Type": "video/mp4"
//               },
//               files: [fileItem],
//               method: UploadMethod.POST,
//               tag: tag,
//               showNotification: true,
//             );

//       setState(() {
//         _tasks.putIfAbsent(
//             tag,
//             () => UploadItem(
//                   id: taskId,
//                   tag: tag,
//                   type: MediaType.Video,
//                   status: UploadTaskStatus.enqueued,
//                 ));
//       });
//     }
//   }

//   Future uploadVideo(String path) async {
//     MediaInfo mediaInfo = await VideoCompress.compressVideo(
//       path,
//       startTime: 0,
//       duration: 90,
//       quality: VideoQuality.MediumQuality,
//       deleteOrigin: false, // It's false by default
//     );
//     logger.d(mediaInfo.filesize);
//     final String savedDir = dirname(mediaInfo.path);
//     final String filename = basename(mediaInfo.path);
//     final tag = "video upload ${_tasks.length + 1} size: ${mediaInfo.filesize}";
//     final url = _uploadUrl(
//         binary: false, name: filename, token: await fp.getUser().getIdToken());

//     var fileItem = FileItem(
//       filename: filename,
//       savedDir: savedDir,
//       fieldname: "file",
//     );

//     var taskId = await uploader.enqueue(
//       url: url,
//       headers: {
//         "Authorization": "Bearer ${await fp.getServiceAccountToken()}",
//         "Content-Type": "video/mp4"
//       },
//       files: [fileItem],
//       method: UploadMethod.POST,
//       tag: tag,
//       showNotification: true,
//     );

//     setState(() {
//       _tasks.putIfAbsent(
//           tag,
//           () => UploadItem(
//                 id: taskId,
//                 tag: tag,
//                 type: MediaType.Video,
//                 status: UploadTaskStatus.enqueued,
//               ));
//     });
//   }

//   Future cancelUpload(String id) async {
//     await uploader.cancel(taskId: id);
//   }

//   Future<Null> _prepare() async {
//     logger.d("loading tasks...");
//     final tasks = await uploader.progress.map((event) => event);
//     logger.d("loaded task");
//     tasks.forEach((task) {
//       _tasks.putIfAbsent(
//           task.tag,
//           () => UploadItem(
//                 id: task.taskId,
//                 tag: task.tag,
//                 type: MediaType.Video,
//                 status: task.status,
//               ));
//     });

//     setState(() {
//       _isLoading = false;
//     });
//   }
// }

// typedef CancelUploadCallback = Future<void> Function(String id);

// class UploadItemView extends StatelessWidget {
//   final UploadItem item;
//   final CancelUploadCallback onCancel;

//   UploadItemView({
//     Key key,
//     this.item,
//     this.onCancel,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final progress = item.progress.toDouble() / 100;
//     final widget = item.status == UploadTaskStatus.running
//         ? LinearProgressIndicator(value: progress)
//         : Container();
//     final buttonWidget = item.status == UploadTaskStatus.running
//         ? Container(
//             height: 50,
//             width: 50,
//             child: IconButton(
//               icon: Icon(Icons.cancel),
//               onPressed: () => onCancel(item.id),
//             ),
//           )
//         : Container();
//     return Row(
//       children: <Widget>[
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Text(item.tag),
//               Container(
//                 height: 5.0,
//               ),
//               Text(item.status.description),
//               Container(
//                 height: 5.0,
//               ),
//               widget
//             ],
//           ),
//         ),
//         buttonWidget
//       ],
//     );
//   }
// }
