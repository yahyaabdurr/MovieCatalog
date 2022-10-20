import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tv_top_rated_movies_notifier.dart';

class TvTopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-top-rated';

  @override
  _TvTopRatedMoviesPageState createState() => _TvTopRatedMoviesPageState();
}

class _TvTopRatedMoviesPageState extends State<TvTopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvTopRatedMoviesNotifier>(context, listen: false)
            .fetchTvTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tv Series - Top Rated'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvTopRatedMoviesNotifier>(
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
