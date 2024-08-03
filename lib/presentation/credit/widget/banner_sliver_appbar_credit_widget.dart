// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_constant.dart';
import '../../../manager/enum/status_enum.dart';
import '../../../manager/widget/custom_spin_widget.dart';
import '../../home/widget/place_holder_image_widget.dart';
import '../bloc/credit_detail_bloc/credit_detail_bloc.dart';
import '../bloc/credit_detail_bloc/credit_detail_state.dart';

class BannerSliverAppBarCreditWidget extends StatelessWidget {
  const BannerSliverAppBarCreditWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditDetailBloc, CreditDetailState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == Status.success) {
          final credit = state.creditEntity;
          return Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: '${AppConstant.imagePathUrlW500}${credit.person!.profilePath}',
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => ClipRRect(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                  padding: const EdgeInsetsDirectional.only(end: 14),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.08),
                      ),
                      child: Center(
                        child: SpinCustomWidget(sized: 50.r),
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const PlaceholderImage(),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.0, 1.0),
                    end: Alignment(0.0, 0.0),
                    colors: <Color>[
                      Color(0x60000000),
                      Color(0x00000000),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
