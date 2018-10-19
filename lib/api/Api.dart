class Api {
  static final String host = "https://cnodejs.org/api/v1";

  // 主题首页
  static final String getAllTopicList = "$host/topics";

  // 资讯详情
  static final String getTopicDetail = "$host/topics/:id";
}