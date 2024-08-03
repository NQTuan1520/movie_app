// import 'dart:developer';

// import 'package:extractor/extractor.dart';
// import 'package:huynd2_assignment/domain/video_download/entity/video_download_entity.dart';
// import 'package:huynd2_assignment/domain/video_download/entity/video_quality_entity.dart';

// class VideoDownloaderRepository {
//   Future<VideoDownloadEntity?> getAvailableYTVideo(String url) async {
//     try {
//       final response = await Extractor.getDirectLink(link: url);
//       if (response != null) {
//         return VideoDownloadEntity.fromJson({
//           "title": response.title,
//           "source": response.links?.first.href,
//           "thumbnail": response.thumbnail,
//           "videos": [
//             VideoQualityEntity(
//               url: response.links?.first.href,
//               quality: "720",
//             )
//           ]
//         });
//       } else {
//         return null;
//       }
//     } on Exception catch (e) {
//       log("Error: $e");
//       return null;
//     } catch (e) {
//       log("Error: $e");
//     }
//   }
// }
