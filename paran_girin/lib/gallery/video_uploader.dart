import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import "package:http/http.dart" as http;
import "package:googleapis_auth/auth_io.dart";
import 'package:video_compress/video_compress.dart';

const String title = "FileUpload Sample app";
const String uploadURL =
    "https://storage.googleapis.com/upload/storage/v1/b/tonal-baton-245112.appspot.com/o?";

const String uploadBinaryURL =
    "https://storage.googleapis.com/upload/storage/v1/b/tonal-baton-245112.appspot.com/o?";

class App extends StatefulWidget {
  final Widget child;

  App({Key key, this.child}) : super(key: key);

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UploadScreen(),
    );
  }
}

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

enum MediaType { Image, Video }

class UploadScreen extends StatefulWidget {
  UploadScreen({Key key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  FlutterUploader uploader = FlutterUploader();
  StreamSubscription _progressSubscription;
  StreamSubscription _resultSubscription;
  Subscription _subscription;
  Map<String, UploadItem> _tasks = {};
  FirebaseProvider fp;
  bool _isLoading;
  @override
  void initState() {
    super.initState();
    // WidgetsFlutterBinding.ensureInitialized();
    // _subscription = VideoCompress.compressProgress$.subscribe((progress) {
    //   debugPrint('progress: $progress');
    // });
    _progressSubscription = uploader.progress.listen((progress) {
      final task = _tasks[progress.tag];
      print("progress: ${progress.progress} , tag: ${progress.tag}");
      if (task == null) return;
      if (task.isCompleted()) return;
      setState(() {
        _tasks[progress.tag] =
            task.copyWith(progress: progress.progress, status: progress.status);
      });
    });
    _resultSubscription = uploader.result.listen((result) {
      print(
          "id: ${result.taskId}, status: ${result.status}, response: ${result.response}, statusCode: ${result.statusCode}, tag: ${result.tag}, headers: ${result.headers}");

      final task = _tasks[result.tag];
      if (task == null) return;

      setState(() {
        _tasks[result.tag] = task.copyWith(status: result.status);
      });
    }, onError: (ex, stacktrace) {
      print("exception: $ex");
      print("stacktrace: $stacktrace" ?? "no stacktrace");
      final exp = ex as UploadException;
      final task = _tasks[exp.tag];
      if (task == null) return;
      setState(() {
        _tasks[exp.tag] = task.copyWith(status: exp.status);
      });
    });
    setState(() {
      _isLoading = true;
    });
    _prepare();
  }

  @override
  void dispose() {
    _progressSubscription?.cancel();
    _resultSubscription?.cancel();
    _isLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(
          builder: (context) => _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 20.0),
                      Text(
                        'multipart/form-data uploads',
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () => getImage(binary: false),
                            child: Text("upload image"),
                          ),
                          Container(width: 20.0),
                          RaisedButton(
                            onPressed: () => getVideo(binary: false),
                            child: Text("upload video"),
                          )
                        ],
                      ),
                      Container(height: 20.0),
                      Text(
                        'binary uploads',
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      Text('this will upload selected files as binary'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () => getImage(binary: true),
                            child: Text("upload image"),
                          ),
                          Container(width: 20.0),
                          RaisedButton(
                            onPressed: () => getVideo(binary: true),
                            child: Text("upload video"),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.all(20.0),
                          itemCount: _tasks.length,
                          itemBuilder: (context, index) {
                            final item = _tasks.values.elementAt(index);
                            print("${item.tag} - ${item.status}");
                            return UploadItemView(
                              item: item,
                              onCancel: cancelUpload,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.black,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }

  String _uploadUrl({bool binary, String name, String token = ""}) {
    if (binary) {
      return uploadBinaryURL + "name=${name}";
    } else {
      return uploadURL + "name=${name}&token=${token}";
    }
  }

  Future getImage({@required bool binary}) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final String filename = basename(image.path);
      final String savedDir = dirname(image.path);
      final tag = "image upload ${_tasks.length + 1}";
      var url = _uploadUrl(binary: binary, name: filename);
      var fileItem = FileItem(
        filename: filename,
        savedDir: savedDir,
        fieldname: "file",
      );
      logger.d("Bearer ${await fp.getServiceAccountToken()}");
      var taskId = binary
          ? await uploader.enqueueBinary(
              url: url,
              file: fileItem,
              method: UploadMethod.POST,
              headers: {
                "Authorization": "Bearer ${await fp.getServiceAccountToken()}",
                "Content-Type": "image/jpeg"
              },
              tag: tag,
              showNotification: true,
            )
          : await uploader.enqueue(
              url: url,
              headers: {
                "Authorization": "Bearer ${await fp.getServiceAccountToken()}",
                "Content-Type": "image/jpeg"
              },
              files: [fileItem],
              method: UploadMethod.POST,
              tag: tag,
              showNotification: true,
            );

      setState(() {
        _tasks.putIfAbsent(
            tag,
            () => UploadItem(
                  id: taskId,
                  tag: tag,
                  type: MediaType.Video,
                  status: UploadTaskStatus.enqueued,
                ));
      });
    }
  }

  Future getVideo({@required bool binary}) async {
    var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      logger.d(await video.length());
      MediaInfo mediaInfo = await VideoCompress.compressVideo(
        video.path,
        startTime: 0,
        duration: 90,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false, // It's false by default
      );
      logger.d(mediaInfo.filesize);
      final String savedDir = dirname(mediaInfo.path);
      final String filename = basename(mediaInfo.path);
      final tag =
          "video upload ${_tasks.length + 1} size: ${await video.length()}";
      final url = _uploadUrl(
          binary: binary,
          name: filename,
          token: await fp.getUser().getIdToken());

      var fileItem = FileItem(
        filename: filename,
        savedDir: savedDir,
        fieldname: "file",
      );

      var taskId = binary
          ? await uploader.enqueueBinary(
              url: url,
              file: fileItem,
              headers: {
                "Authorization": "Bearer ${await fp.getServiceAccountToken()}",
              },
              method: UploadMethod.POST,
              tag: tag,
              showNotification: true,
            )
          : await uploader.enqueue(
              url: url,
              headers: {
                "Authorization": "Bearer ${await fp.getServiceAccountToken()}",
                "Content-Type": "video/mp4"
              },
              files: [fileItem],
              method: UploadMethod.POST,
              tag: tag,
              showNotification: true,
            );

      setState(() {
        _tasks.putIfAbsent(
            tag,
            () => UploadItem(
                  id: taskId,
                  tag: tag,
                  type: MediaType.Video,
                  status: UploadTaskStatus.enqueued,
                ));
      });
    }
  }

  Future cancelUpload(String id) async {
    await uploader.cancel(taskId: id);
  }

  Future<Null> _prepare() async {
    logger.d("loading tasks...");
    final tasks = await uploader.progress.map((event) => event);
    logger.d("loaded task");
    tasks.forEach((task) {
      _tasks.putIfAbsent(
          task.tag,
          () => UploadItem(
                id: task.taskId,
                tag: task.tag,
                type: MediaType.Video,
                status: task.status,
              ));
    });

    setState(() {
      _isLoading = false;
    });
  }
}

typedef CancelUploadCallback = Future<void> Function(String id);

class UploadItemView extends StatelessWidget {
  final UploadItem item;
  final CancelUploadCallback onCancel;

  UploadItemView({
    Key key,
    this.item,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = item.progress.toDouble() / 100;
    final widget = item.status == UploadTaskStatus.running
        ? LinearProgressIndicator(value: progress)
        : Container();
    final buttonWidget = item.status == UploadTaskStatus.running
        ? Container(
            height: 50,
            width: 50,
            child: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () => onCancel(item.id),
            ),
          )
        : Container();
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(item.tag),
              Container(
                height: 5.0,
              ),
              Text(item.status.description),
              Container(
                height: 5.0,
              ),
              widget
            ],
          ),
        ),
        buttonWidget
      ],
    );
  }
}
