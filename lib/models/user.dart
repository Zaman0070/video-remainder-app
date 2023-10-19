// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? userEmail;
  final String? userImage;
  final String? userName;
  final String? userPhone;
  final String? userDescription;
  final String? token;
  final String? uid;
  UserModel({
    this.userEmail,
    this.userImage,
    this.userName,
    this.userPhone,
    this.userDescription,
    this.token,
    this.uid,
  });

  UserModel copyWith({
    String? userEmail,
    String? userImage,
    String? userName,
    String? userPhone,
    String? userDescription,
    String? token,
    String? uid,
  }) {
    return UserModel(
      userEmail: userEmail ?? this.userEmail,
      userImage: userImage ?? this.userImage,
      userName: userName ?? this.userName,
      userPhone: userPhone ?? this.userPhone,
      userDescription: userDescription ?? this.userDescription,
      token: token ?? this.token,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userEmail': userEmail,
      'userImage': userImage,
      'userName': userName,
      'userPhone': userPhone,
      'userDescription': userDescription,
      'token': token,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      userImage: map['userImage'] != null ? map['userImage'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      userPhone: map['userPhone'] != null ? map['userPhone'] as String : null,
      userDescription: map['userDescription'] != null ? map['userDescription'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userEmail: $userEmail, userImage: $userImage, userName: $userName, userPhone: $userPhone, userDescription: $userDescription, token: $token, uid: $uid)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userEmail == userEmail &&
      other.userImage == userImage &&
      other.userName == userName &&
      other.userPhone == userPhone &&
      other.userDescription == userDescription &&
      other.token == token &&
      other.uid == uid;
  }

  @override
  int get hashCode {
    return userEmail.hashCode ^
      userImage.hashCode ^
      userName.hashCode ^
      userPhone.hashCode ^
      userDescription.hashCode ^
      token.hashCode ^
      uid.hashCode;
  }
}
