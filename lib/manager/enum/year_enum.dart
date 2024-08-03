enum Year { y2024, y2023, y2022 }

extension YearExtension on Year {
  String get year {
    switch (this) {
      case Year.y2024:
        return '2024';
      case Year.y2023:
        return '2023';
      case Year.y2022:
        return '2022';
      default:
        return '';
    }
  }
}
