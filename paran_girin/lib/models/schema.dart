import 'dart:io';

import 'package:flutter/widgets.dart';

class StaticInfo {
  Map<String, Question> questions = Map<String, Question>();
  List<Post> posts = List<Post>();
  Map<String, String> post_videos = Map<String, String>();
  Map<String, File> post_thumbnails = Map<String, File>();
  Map<String, Child> post_children = Map<String, Child>();
  Map<String, File> post_profiles = Map<String, File>();
  Map<String, Answer> answers = Map<String, Answer>();
  File profile;
  String profileURL;
}

class UserModel {
  String id;
  String displayName;
  String email;
  UserInDB userInDB;
  Child currentChild;
}

class UserInDB {
  String sharedID;
  String currentChild;
  bool pushAlarm = false;
  List<String> children = List<String>();
  UserInDB.sharedID(String sharedID);
  UserInDB.fromJson(Map<String, dynamic> json)
      : this.sharedID = json['sharedID'],
        this.currentChild = json['currentChild'],
        this.children = json['children'].cast<String>();
  // this.pushAlarm = json['pushAlarm'].cast<bool>();
  Map<String, dynamic> toJson() => {
        'sharedID': sharedID,
        'currentChild': currentChild,
        'children': children,
        'pushAlarm': pushAlarm
      };
}

class Child {
  String name;
  String nickName;
  String profileURL;
  int birthday;
  String background;
  String avatar;
  Map<String, String> answers = Map<String, String>();
  Child(this.name, this.profileURL, this.nickName, this.birthday, this.avatar);
  Child.fromJson(Map<String, dynamic> json)
      : this.name = json['name'],
        this.nickName = json['nickName'],
        this.profileURL = json['profileURL'],
        this.birthday = json['birthday'],
        this.avatar = json['avatar'] ?? 'nod.gif',
        this.background = json['background'] ?? 'lv2.jpg',
        this.answers = (json['answers'] == null)
            ? Map<String, String>()
            : json['answers'].cast<String, String>();

  Map<String, dynamic> toJson() => {
        'name': name,
        'nickName': nickName,
        'profileURL': profileURL,
        'birthday': birthday,
        'background': background,
        'avatar': avatar,
        'answers': answers
      };
}

class Avatar {
  List<String> costume = List<String>();
  Avatar.fromJson(Map<String, dynamic> json)
      : this.costume = json['costume'].cast<String>();
  Map<String, dynamic> toJson() => {'costume': costume};
}

class Question {
  int qid;
  String title;
  String category;
  String story;
  String question;
  String narration1;
  String narration2;
  String guide;
  String tag;
  String videoURL;

  Question.fromJson(Map<String, dynamic> json)
      : this.qid = json['qid'],
        this.title = json['title'],
        this.category = json['category'],
        this.story = json['story'],
        this.question = json['question'],
        this.narration1 = json['narration1'],
        this.narration2 = json['narration2'],
        this.guide = json['guide'],
        this.tag = json['tag'],
        this.videoURL = json['videoURL'];
  Map<String, dynamic> toJson() => {
        'qid': qid,
        'title': title,
        'category': category,
        'story': story,
        'question': question,
        'narration1': narration1,
        'narration2': narration2,
        'guide': guide,
        'tag': tag,
        'videoURL': videoURL
      };
  bool containsKeyWord(String key) {
    Map<String, dynamic> json = this.toJson();
    for (var s in json.values) {
      if (s == null) {
        continue;
      }
      if (s.runtimeType != String) {
        continue;
      }
      if (s.replaceAll(' ', '').contains(key)) {
        return true;
      }
    }
    return false;
  }
}

class Answer {
  int date;
  String videoURL;
  String dbURL;
  // String thumbURL;
  File thumbnail;
  bool posted;
  Answer(this.date, this.videoURL, this.posted);
  Answer.fromJson(Map<String, dynamic> json)
      : this.date = json['date'],
        this.videoURL = json['videoURL'],
        this.dbURL = json['dbURL'],
        // this.thumbURL = json['thumbURL'],
        this.posted = json['posted'];
  Map<String, dynamic> toJson() =>
      {'date': date, 'videoURL': videoURL, 'dbURL': dbURL, 'posted': posted};
      // {'date': date, 'videoURL': videoURL, 'dbURL': dbURL, 'thumbURL': thumbURL, 'posted': posted};

  bool containsKeyWord(String key) {
    Map<String, dynamic> json = this.toJson();
    for (var s in json.values) {
      if (s == null) {
        continue;
      }
      if (s.runtimeType != String) {
        continue;
      }
      if (s.replaceAll(' ', '').contains(key)) {
        return true;
      }
    }
    return false;
  }
}

class Post {
  int date;
  int likes = 0;
  String qid;
  String title;
  String child;
  String videoURL;
  String thumbURL;
  String comment = "";
  List<String> likedPPL = List<String>();
  Post(this.date, this.qid, this.title, this.child, this.videoURL, this.thumbURL,
      this.comment);
  Post.fromJson(Map<String, dynamic> json)
      : this.date = json['date'],
        this.qid = json['qid'],
        this.likes = json['likes'],
        this.title = json['title'],
        this.child = json['child'],
        this.videoURL = json['videoURL'],
        this.thumbURL = json['thumbURL'],
        this.comment = json['comment'],
        this.likedPPL = json['likedPPL'].cast<String>();
  Map<String, dynamic> toJson() => {
        'date': date,
        'qid': qid,
        'likes': likes,
        'title': title,
        'child': child,
        'videoURL': videoURL,
        'thumbURL': thumbURL,
        'comment': comment,
        'likedPPL': likedPPL
      };
}

class NoticeItem {
  int date;
  String id;
  String title;
  String content;
  NoticeItem(this.date, this.id, this.title, this.content);
  NoticeItem.fromJson(Map<String, dynamic> json)
      : this.date = json['date'],
        this.id = json['id'],
        this.title = json['title'],
        this.content = json['content'];
  Map<String, dynamic> toJson() =>
      {'date': date, 'id': id, 'title': title, 'content': content};
}

class FaqItem {
  int order;
  String id;
  String title;
  String content;
  FaqItem(this.order, this.id, this.title, this.content);
  FaqItem.fromJson(Map<String, dynamic> json)
      : this.order = json['order'],
        this.id = json['id'],
        this.title = json['title'],
        this.content = json['content'];
  Map<String, dynamic> toJson() =>
      {'date': order, 'id': id, 'title': title, 'content': content};
}

class OpinionQuestion {
  int date;
  String id;
  String writer;
  String content;
  OpinionQuestion(this.date, this.id, this.writer, this.content);
  OpinionQuestion.fromJson(Map<String, dynamic> json)
      : this.date = json['date'],
        this.id = json['id'],
        this.writer = json['writer'],
        this.content = json['content'];
  Map<String, dynamic> toJson() =>
      {'date': date, 'id': id, 'writer': writer, 'content': content};
}

class OpinionWish {
  int date;
  String id;
  String writer;
  String content;
  OpinionWish(this.date, this.id, this.writer, this.content);
  OpinionWish.fromJson(Map<String, dynamic> json)
      : this.date = json['date'],
        this.id = json['id'],
        this.writer = json['writer'],
        this.content = json['content'];
  Map<String, dynamic> toJson() =>
      {'date': date, 'id': id, 'writer': writer, 'content': content};
}
