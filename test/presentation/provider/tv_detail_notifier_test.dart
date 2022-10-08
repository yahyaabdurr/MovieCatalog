import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvMovieDetail,
  GetTvMovieRecommendations,
  GetTvWatchListStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvMovieDetail mockGetTvMovieDetail;
  late MockGetTvMovieRecommendations mockGetTvMovieRecommendations;
  late MockGetTvWatchListStatus mockGetTvWatchListStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvMovieDetail = MockGetTvMovieDetail();
    mockGetTvMovieRecommendations = MockGetTvMovieRecommendations();
    mockGetTvWatchListStatus = MockGetTvWatchListStatus();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    provider = TvDetailNotifier(
      getTvMovieDetail: mockGetTvMovieDetail,
      getTvMovieRecommendations: mockGetTvMovieRecommendations,
      getTvWatchListStatus: mockGetTvWatchListStatus,
      saveWatchlistTv: mockSaveTvWatchlist,
      removeWatchlistTv: mockRemoveTvWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  void _arrangeUsecase() {
    when(mockGetTvMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockGetTvMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesList));
  }

  group('Get Tv Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvMovieDetail(tId);
      // assert
      verify(mockGetTvMovieDetail.execute(tId));
      verify(mockGetTvMovieRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvMovieDetail(tId);
      // assert
      expect(provider.movieState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv movie detail when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvMovieDetail(tId);
      // assert
      expect(provider.movieState, RequestState.Loaded);
      expect(provider.movie, testTvSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tv movies when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvMovieDetail(tId);
      // assert
      expect(provider.movieState, RequestState.Loaded);
      expect(provider.movieRecommendations, testTvSeriesList);
    });
  });

  group('Get Tv Movie Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvMovieDetail(tId);
      // assert
      verify(mockGetTvMovieRecommendations.execute(tId));
      expect(provider.movieRecommendations, testTvSeriesList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvMovieDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.movieRecommendations, testTvSeriesList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      when(mockGetTvMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvMovieDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist tv status', () async {
      // arrange
      when(mockGetTvWatchListStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistTvStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveTvWatchlist.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetTvWatchListStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvSeriesDetail);
      // assert
      verify(mockSaveTvWatchlist.execute(testTvSeriesDetail));
    });

    test('should execute remove watchlist tv when function called', () async {
      // arrange
      when(mockRemoveTvWatchlist.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetTvWatchListStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvSeriesDetail);
      // assert
      verify(mockRemoveTvWatchlist.execute(testTvSeriesDetail));
    });

    test('should update watchlist tv status when add watchlist tv success',
        () async {
      // arrange
      when(mockSaveTvWatchlist.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetTvWatchListStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvSeriesDetail);
      // assert
      verify(mockGetTvWatchListStatus.execute(testTvSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveTvWatchlist.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvWatchListStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      await provider.fetchTvMovieDetail(tId);
      // assert
      expect(provider.movieState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
