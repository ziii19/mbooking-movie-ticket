import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/constants/movie_category.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/core/utils/capital.dart';
import 'package:mbooking/features/main/pages/cubit/nav_index_cubit.dart';
import 'package:mbooking/features/main/pages/main_page.dart';
import 'package:mbooking/features/movie/presentation/blocs/cubit/category_index_cubit.dart';
import 'package:mbooking/features/movie/presentation/pages/movie_detail_booking/movie_detail_booking.dart';

import '../../../../../core/utils/get_genre_names.dart';
import '../../../../auth/presentation/blocs/user/user_bloc.dart';
import '../../blocs/movie/movies_bloc.dart';
import '../../widgets/movie_slider_card.dart';
import '../../widgets/title_section.dart';
import '../../widgets/upcoming_card.dart';

part 'section/user_section.dart';
part 'section/now_playing_slider.dart';
part 'section/coming_soon_section.dart';
part 'section/promo_section.dart';
part 'section/service_section.dart';
part 'section/movie_news_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _UserSection(),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  prefixIcon: Icon(Icons.search, color: AppColors.gray),
                  hintText: 'Search',
                  fillColor: AppColors.enabled,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const _NowPlayingSlider(),
              const SizedBox(height: 16),
              const _ComingSoonSection(),
              const SizedBox(height: 16),
              const _PromoSection(),
              const SizedBox(height: 16),
              const _ServiceSection(),
              const SizedBox(height: 16),
              const _MovieNewsSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      )),
    );
  }
}
