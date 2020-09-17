class User {
  String username;
  String firstName;
  String lastName;
  String phoneNumber;
  String emailAddress;
  String bio;
  String photoURL;
  String following;
  String followers;
  String postCount;

  User(
      {this.username,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.emailAddress,
      this.bio,
      this.photoURL,
      this.following,
      this.followers,
      this.postCount});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    emailAddress = json['emailAddress'];
    bio = json['bio'];
    photoURL = json['photoURL'];
    following = json['following'];
    followers = json['followers'];
    postCount = json['postCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    data['emailAddress'] = this.emailAddress;
    data['bio'] = this.bio;
    data['photoURL'] = this.photoURL;
    data['following'] = this.following;
    data['followers'] = this.followers;
    data['postCount'] = this.postCount;
    return data;
  }
}
