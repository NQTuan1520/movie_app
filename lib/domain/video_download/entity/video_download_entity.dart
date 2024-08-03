// // ignore_for_file: must_be_immutable

// import 'package:equatable/equatable.dart';
// import 'package:huynd2_assignment/domain/video_download/entity/video_quality_entity.dart';

// class VideoDownloadEntity extends Equatable {
//   String? _title;
//   String? _source;
//   String? _thumbnail;
//   List<VideoQualityEntity>? _videoQuality;

//   VideoDownloadEntity({
//     String? title,
//     String? source,
//     String? thumbnail,
//     List<VideoQualityEntity>? videoQuality,
//   }) {
//     _title = title;
//     _source = source;
//     _thumbnail = thumbnail;
//     _videoQuality = videoQuality;
//   }

//   //getter
//   String? get title => _title;
//   set title(String? title) {
//     _title = title;
//   }

//   String? get source => _source;
//   set source(String? source) {
//     _source = source;
//   }

//   String? get thumbnail => _thumbnail;
//   set thumbnail(String? thumbnail) {
//     _thumbnail = thumbnail;
//   }

//   List<VideoQualityEntity>? get videoQuality => _videoQuality;
//   set videoQuality(List<VideoQualityEntity>? videoQuality) {
//     _videoQuality = videoQuality;
//   }

//   //from json
//   VideoDownloadEntity.fromJson(Map<String, dynamic> json) {
//     _title = json['title'];
//     _source = json['source'];
//     _thumbnail = json['thumbnail'];
//     if (json['videoQuality'] != null) {
//       _videoQuality = <VideoQualityEntity>[];
//       json['videoQuality'].forEach((v) {
//         _videoQuality!.add(VideoQualityEntity.fromJson(v));
//       });
//     }
//   }

//   //to json
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = _title;
//     data['source'] = _source;
//     data['thumbnail'] = _thumbnail;
//     if (_videoQuality != null) {
//       data['videoQuality'] = _videoQuality!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }

//   @override
//   // TODO: implement props
//   List<Object?> get props => [_title, _source, _thumbnail, _videoQuality];
// }
