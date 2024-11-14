class Page {
  int totalPages;
  int currentPage;

  Page({this.totalPages = 0, this.currentPage = 0});

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'totalPages': totalPages,
      'currentPage': currentPage,
    };
  }

  // Factory constructor để tạo đối tượng từ JSON
  factory Page.fromJson(Map<String, dynamic> json) {
    return Page(
      totalPages: json['totalPages'],  // Nếu không có thì gán 0
      currentPage: json['currentPage'],  // Nếu không có thì gán 0
    );
  }
}
