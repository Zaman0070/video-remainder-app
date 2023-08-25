// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VideoModel {
  final String? uid;
  final String? videoUrl;
  final String? videoThumbnailUrl;
  final String? title;
  final String? description;
  final String? category;
  final String? remainderDate;
  final String? remainderTime;
  final String? reminderTitle;
  final String? time;
  VideoModel({
    this.uid,
    this.videoUrl,
    this.videoThumbnailUrl,
    this.title,
    this.description,
    this.category,
    this.remainderDate,
    this.remainderTime,
    this.reminderTitle,
    this.time,
  });

  VideoModel copyWith({
    String? uid,
    String? videoUrl,
    String? videoThumbnailUrl,
    String? title,
    String? description,
    String? category,
    String? remainderDate,
    String? remainderTime,
    String? reminderTitle,
    String? time,
  }) {
    return VideoModel(
      uid: uid ?? this.uid,
      videoUrl: videoUrl ?? this.videoUrl,
      videoThumbnailUrl: videoThumbnailUrl ?? this.videoThumbnailUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      remainderDate: remainderDate ?? this.remainderDate,
      remainderTime: remainderTime ?? this.remainderTime,
      reminderTitle: reminderTitle ?? this.reminderTitle,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'videoUrl': videoUrl,
      'videoThumbnailUrl': videoThumbnailUrl,
      'title': title,
      'description': description,
      'category': category,
      'remainderDate': remainderDate,
      'remainderTime': remainderTime,
      'reminderTitle': reminderTitle,
      'time': time,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      videoUrl: map['videoUrl'] != null ? map['videoUrl'] as String : null,
      videoThumbnailUrl: map['videoThumbnailUrl'] != null ? map['videoThumbnailUrl'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      remainderDate: map['remainderDate'] != null ? map['remainderDate'] as String : null,
      remainderTime: map['remainderTime'] != null ? map['remainderTime'] as String : null,
      reminderTitle: map['reminderTitle'] != null ? map['reminderTitle'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) => VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoModel(uid: $uid, videoUrl: $videoUrl, videoThumbnailUrl: $videoThumbnailUrl, title: $title, description: $description, category: $category, remainderDate: $remainderDate, remainderTime: $remainderTime, reminderTitle: $reminderTitle, time: $time)';
  }

  @override
  bool operator ==(covariant VideoModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.videoUrl == videoUrl &&
      other.videoThumbnailUrl == videoThumbnailUrl &&
      other.title == title &&
      other.description == description &&
      other.category == category &&
      other.remainderDate == remainderDate &&
      other.remainderTime == remainderTime &&
      other.reminderTitle == reminderTitle &&
      other.time == time;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      videoUrl.hashCode ^
      videoThumbnailUrl.hashCode ^
      title.hashCode ^
      description.hashCode ^
      category.hashCode ^
      remainderDate.hashCode ^
      remainderTime.hashCode ^
      reminderTitle.hashCode ^
      time.hashCode;
  }
}
