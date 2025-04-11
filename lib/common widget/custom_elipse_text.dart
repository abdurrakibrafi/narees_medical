String customEllipsisText(String text, {int wordLimit = 4}) {
  final words = text.split(' ');

  return words.length > wordLimit
      ? words.sublist(0, wordLimit).join(' ') + '...'
      : text;
}
