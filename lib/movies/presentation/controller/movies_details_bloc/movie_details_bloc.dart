import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../../domain/use_cases/get_movies_details_use_case.dart';
import '../../../domain/use_cases/get_recommendation_use_case.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc(this.getMoviesDetailsUseCase, this.getRecommendationUseCase)
      : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetMovieRecommendationEvent>(_getRecommendation);
  }

  final GetMoviesDetailsUseCase getMoviesDetailsUseCase;
  final GetRecommendationUseCase getRecommendationUseCase;

  FutureOr<void> _getMovieDetails(
      GetMovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    final result = await getMoviesDetailsUseCase(
      MovieDetailsParameters(
        movieId: event.id,
      ),
    );
    result.fold(
      (error) => emit(state.copyWith(
        movieDetailsState: RequestState.error,
        movieDetailsErrorMessage: error.message,
      )),
      (movieDetails) => emit(
        state.copyWith(
          movieDetailsState: RequestState.loaded,
          movieDetails: movieDetails,
        ),
      ),
    );
  }

  FutureOr<void> _getRecommendation(GetMovieRecommendationEvent event,
      Emitter<MovieDetailsState> emit) async {
    final result = await getRecommendationUseCase(
      RecommendationParameters(
        event.id,
      ),
    );
    result.fold(
      (error) => emit(state.copyWith(
        recommendationState: RequestState.error,
        recommendationErrorMessage: error.message,
      )),
      (data) => emit(
        state.copyWith(
          recommendationState: RequestState.loaded,
          recommendationMovies: data,
        ),
      ),
    );
  }
}
