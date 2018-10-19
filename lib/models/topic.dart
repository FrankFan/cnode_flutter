class Topic {
  final String title;
  final String loginName;
  final String avatarUrl;
  final int replyCount;
  final int visitCount;

  Topic({this.title, this.loginName,this.avatarUrl, this.replyCount, this.visitCount});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      title: json['title'],
      loginName: json['author']['loginname'],
      avatarUrl: json['author']['avatar_url'],
      replyCount: json['reply-count'],
      visitCount: json['visit-count'],
    );
  }
}
