import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/tv_show_detail/enitty/tv_detail_entity.dart';
import '../../../manager/color.dart';
import 'all_episode_widget.dart';
import 'last_episode_widget.dart';
import 'next_episode_widget.dart';

class EpisodeSectionWidget extends StatefulWidget {
  final TVDetailEntity tvDetailEntity;

  const EpisodeSectionWidget({super.key, required this.tvDetailEntity});

  @override
  State<EpisodeSectionWidget> createState() => _EpisodeSectionWidgetState();
}

class _EpisodeSectionWidgetState extends State<EpisodeSectionWidget> {
  String _selectedOption = 'All Episodes';
  TVDetailEntity get tvDetailEntity => widget.tvDetailEntity;
  Episode? get lastEpisode => tvDetailEntity.lastEpisodeToAir;
  Episode? get nextEpisode => tvDetailEntity.nextEpisodeToAir;
  List<Season> get allEpisodes => tvDetailEntity.seasons ?? [];

  @override
  Widget build(BuildContext context) {
    List<Widget> getEpisodes() {
      switch (_selectedOption) {
        case 'Last Episode':
          if (lastEpisode != null) {
            return [
              LastEpisodeWidget(lastEpisode: lastEpisode!, tvDetailEntity: tvDetailEntity),
            ];
          } else {
            return [
              const Center(
                child: Text('Last episode information is not available.'),
              ),
            ];
          }
        case 'Next Episode':
          if (nextEpisode != null) {
            return [
              NextEpisodeWidget(nextEpisode: nextEpisode!, tvDetailEntity: tvDetailEntity),
            ];
          } else {
            return [
              const Center(
                child: Text('Next episode information is not available.'),
              ),
            ];
          }
        default:
          return allEpisodes.map((episode) {
            return AllEpisodeWidget(episode: episode);
          }).toList();
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: _selectedOption,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? TAppColor.darkFadeBlueColor
                  : TAppColor.whiteGreyColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              prefixIcon: const Icon(Icons.tv, color: TAppColor.primaryColor),
            ),
            dropdownColor:
                Theme.of(context).brightness == Brightness.dark ? TAppColor.darkBlueColor : TAppColor.whiteLightColor,
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? TAppColor.whiteGreyColor
                    : TAppColor.darkBlueColor,
                fontSize: 16),
            items: ['All Episodes', 'Last Episode', 'Next Episode'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedOption = newValue ?? 'All Episodes';
              });
            },
            icon: const Icon(
              Icons.arrow_drop_down,
              color: TAppColor.primaryColor,
            ),
          ),
          22.verticalSpace,
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: getEpisodes(),
            ),
          ),
        ],
      ),
    );
  }
}
