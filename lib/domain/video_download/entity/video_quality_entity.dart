// import 'package:equatable/equatable.dart';

// class VideoQualityEntity extends Equatable {
//   String? _url;
//   String? _quality;

//   VideoQualityEntity({
//     String? url,
//     String? quality,
//   }) {
//     if (url == null || quality == null) {
//       throw Exception('url and quality must not be null');
//     }
//     _url = url;
//     _quality = quality;
//   }

//   //getter
//   String? get url => _url;
//   set url(String? url) {
//     if (url == null) {
//       throw Exception('url must not be null');
//     }
//     _url = url;
//   }

//   //getter
//   String? get quality => _quality;
//   set quality(String? quality) {
//     if (quality == null) {
//       throw Exception('quality must not be null');
//     }
//     _quality = quality;
//   }

//   //from json
//   VideoQualityEntity.fromJson(Map<String, dynamic> json) {
//     if (json['url'] == null || json['quality'] == null) {
//       throw Exception('url and quality must not be null');
//     }
//     _url = json['url'];
//     _quality = json['quality'];
//   }
//   //to json
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['url'] = _url;
//     data['quality'] = _quality;
//     return data;
//   }

//   @override
//   // TODO: implement props
//   List<Object?> get props => [_url, _quality];
// }
