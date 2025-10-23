int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  const wordsPerMinute = 225; // average reading speed
  final readingTime = wordCount / wordsPerMinute;

  return readingTime.ceil();
}
