enum UserDocType {
  none,
  passport,
  nationalCard,
}

extension UserDocTypeExtension on UserDocType {
  String get value {
    String key = toString().split('.').last;
    if (key.isEmpty || key == 'null') {
      return '';
    }

    return key.toLowerCase();
  }
}
