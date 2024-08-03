import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/domain/trailer/entity/trailer_entity.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/presentation/home/widget/place_holder_image_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class TrailerListWidget extends StatefulWidget {
  final List<TrailerEntity> trailers;
  final Function(String) playVideo;

  const TrailerListWidget({super.key, required this.trailers, required this.playVideo});

  @override
  State<TrailerListWidget> createState() => _TrailerListWidgetState();
}

class _TrailerListWidgetState extends State<TrailerListWidget> {
  static const int maxDownloads = 5;
  bool isDownloading = false;
  double downloadProgress = 0.0;
  String currentDownloadingVideoId = '';

  Future<void> _downloadVideo(String videoId, String videoName, String videoImage) async {
    if (isDownloading) {
      _showSnackBar('another_download'.tr());
      return;
    }

    final pref = await SharedPreferences.getInstance();
    final downloadedVideos = pref.getStringList('downloadedVideos') ?? [];

    if (downloadedVideos.length >= maxDownloads) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have reached the download limit of $maxDownloads videos.')),
      );
      return;
    }

    final status = await Permission.storage.request();

    if (status.isGranted) {
      setState(() {
        isDownloading = true;
        currentDownloadingVideoId = videoId;
        downloadProgress = 0.0;
      });

      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$videoName.mp4';

      try {
        final yt = YoutubeExplode();
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var streamInfo = manifest.muxed.withHighestBitrate();
        var stream = yt.videos.streamsClient.get(streamInfo);

        var file = File(filePath);
        var fileStream = file.openWrite();

        await for (var data in stream) {
          fileStream.add(data);
          setState(() {
            downloadProgress += data.length / streamInfo.size.totalBytes * 100;
          });
        }

        await fileStream.flush();
        await fileStream.close();

        await saveVideoMetadata(videoId, videoName, videoImage);
        if (!mounted) return;
        _showSnackBar('video_download_success'.tr());
      } catch (e) {
        if (!mounted) return;
        _showSnackBar('Error downloading video: $e');
      } finally {
        setState(() {
          isDownloading = false;
          currentDownloadingVideoId = '';
          downloadProgress = 0.0;
        });
      }
    } else {
      if (!mounted) return;
      _showSnackBar('Permission denied');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> saveVideoMetadata(String videoId, String videoName, String videoImage) async {
    final pref = await SharedPreferences.getInstance();
    final downloadedVideos = pref.getStringList('downloadedVideos') ?? [];

    downloadedVideos.add('$videoName|$videoId|$videoImage');
    await pref.setStringList('downloadedVideos', downloadedVideos);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.trailers.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final trailerItem = widget.trailers[index];
        final thumbnailUrl = 'https://img.youtube.com/vi/${trailerItem.key}/0.jpg';

        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          child: InkWell(
            onTap: () {
              widget.playVideo(trailerItem.key ?? '');
            },
            child: Container(
              height: 100.h,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          height: 70.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: thumbnailUrl,
                                fit: BoxFit.cover,
                                imageBuilder: (context, imageProvider) => ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                  child: SpinCustomWidget(sized: 50.r),
                                ),
                                errorWidget: (context, url, error) => const PlaceholderImage(),
                              ),
                              if (isDownloading && currentDownloadingVideoId == trailerItem.key)
                                Center(
                                  child: CircularProgressIndicator(
                                    value: downloadProgress / 100,
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trailerItem.name ?? 'NaN',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? TAppColor.whiteLightColor
                                      : TAppColor.darkFadeBlueColor,
                                ),
                              ),
                              10.verticalSpace,
                              Text(
                                trailerItem.publishedAt ?? 'NaN',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? TAppColor.whiteLightColor
                                      : TAppColor.darkFadeBlueColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.download_for_offline_outlined),
                    onPressed: isDownloading
                        ? null
                        : () {
                            _downloadVideo(trailerItem.key ?? '', trailerItem.name ?? '', thumbnailUrl);
                          },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
