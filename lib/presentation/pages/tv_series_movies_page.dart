import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_movies_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeriesMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-movie';

  @override
  _TvSeriesMoviesPageState createState() => _TvSeriesMoviesPageState();
}

class _TvSeriesMoviesPageState extends State<TvSeriesMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvSeriesMoviesNotifier>(context, listen: false)
            .fetchTvSeriesMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tv Series Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvSeriesMoviesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movies[index];
                  return TvCard(movie);
                },
                itemCount: data.movies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
