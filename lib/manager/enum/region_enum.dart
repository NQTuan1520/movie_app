// ignore_for_file: constant_identifier_names

enum Region { US, UK, JP, KR, CN, VN }

extension RegionExtension on Region {
  String get name {
    switch (this) {
      case Region.US:
        return 'US';
      case Region.UK:
        return 'UK';
      case Region.JP:
        return 'JP';
      case Region.KR:
        return 'KR';
      case Region.CN:
        return 'CN';
      case Region.VN:
        return 'VN';
      default:
        return '';
    }
  }
}
