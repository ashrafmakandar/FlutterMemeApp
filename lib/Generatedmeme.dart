class Generatememe {
  bool success;
  Data data;

  Generatememe({this.success, this.data});

  Generatememe.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String url;
  String pageUrl;

  Data({this.url, this.pageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    pageUrl = json['page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['page_url'] = this.pageUrl;
    return data;
  }
}