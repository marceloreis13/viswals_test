enum UserDocType {
  none,
  passport,
  nationalCard,
}

extension UserDocTypeExtension on UserDocType {
  String get title {
    switch (this) {
      case UserDocType.passport:
        return 'Passport';
      case UserDocType.nationalCard:
        return 'National Card';
      case UserDocType.none:
        return '';
    }
  }

  String get value {
    String key = toString().split('.').last;
    if (key.isEmpty || key == 'null') {
      return '';
    }

    return key.toLowerCase();
  }
}
