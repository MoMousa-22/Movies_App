import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/movies/presentation/controller/movies_details_bloc/movie_details_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movies_details_bloc/movie_details_state.dart';
import 'package:movies_app/movies/presentation/widgets/show_duration.dart';
import 'package:movies_app/movies/presentation/widgets/show_genres.dart';

class DetailsTextSliver extends StatelessWidget {
  const DetailsTextSliver({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          return SliverToBoxAdapter(
            child: FadeInUp(
              from: 20,
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.movieDetails!.title,
                        style: GoogleFonts.poppins(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        )),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2.0,
                            horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            state.movieDetails!.releaseDate.split('-')[0],
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              (state.movieDetails!.voteAverage / 2)
                                  .toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              '(${state.movieDetails!.voteAverage})',
                              style: const TextStyle(
                                fontSize: 1.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          showDuration(state.movieDetails!.runtime),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      state.movieDetails!.overview,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${AppStrings.genres}: ${showGenres(state.movieDetails!.genres)}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
