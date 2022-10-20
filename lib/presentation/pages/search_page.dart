import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isSearching = false;

  static List<Widget> _views = [
    resultMovies(),
    resultTvSeries(),
  ];

  static const List<Tab> _tabs = [
    const Tab(text: 'Movies'),
    const Tab(text: 'Tv Series'),
  ];
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget searchTextField() {
    return TextField(
      autofocus: true,
      onSubmitted: (query) {
        Provider.of<MovieSearchNotifier>(context, listen: false)
            .fetchMovieSearch(query);

        Provider.of<MovieSearchNotifier>(context, listen: false)
            .fetchTvMovieSearch(query);
      },
      decoration: InputDecoration(hintText: "Search movies, tv series..."),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const SizedBox(
            height: 24,
            width: 24,
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        title: _isSearching ? searchTextField() : Text("Search Page"),
        actions: [
          _isSearching
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                    });
                  })
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  })
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _views,
      ),
    );
  }
}

Widget resultTvSeries() {
  return Consumer<MovieSearchNotifier>(
    builder: (context, data, child) {
      if (data.tvMovieState == RequestState.Loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (data.tvMovieState == RequestState.Loaded) {
        final result = data.searchTvSeriesResult;
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final movie = data.searchTvSeriesResult[index];
            return TvCard(movie);
          },
          itemCount: result.length,
        );
      } else {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(child: Text("Data tidak tersedia")),
        );
      }
    },
  );
}

Widget resultMovies() {
  return Consumer<MovieSearchNotifier>(
    builder: (context, data, child) {
      if (data.movieState == RequestState.Loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (data.movieState == RequestState.Loaded) {
        final result = data.searchMoviesResult;
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final movie = data.searchMoviesResult[index];
            return MovieCard(movie);
          },
          itemCount: result.length,
        );
      } else {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(child: Text("Data tidak tersedia")),
        );
      }
    },
  );
}
