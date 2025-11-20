class Post {
  final String time;
  final String date;
  final String month;
  final int likes;
  final String text;
  final String imageAsset;

  Post({
    required this.time,
    required this.date,
    required this.month,
    required this.likes,
    required this.text,
    required this.imageAsset,
  });

  // Helper method to get formatted timestamp (e.g., "29 Oct 22:12")
  String get formattedTimestamp => '$date $month $time';
}
