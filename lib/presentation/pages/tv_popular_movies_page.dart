import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_popular_movies_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvPopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-popular-movie';

  @override
  _TvPopularMoviesPageState createState() => _TvPopularMoviesPageState();
}

class _TvPopularMoviesPageState extends State<TvPopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvPopularMoviesNotifier>(context, listen: false)
            .fetchTvPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tv Series - Popular'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvPopularMoviesNotifier>(
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
